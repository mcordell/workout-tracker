# == Schema Information
#
# Table name: cycles
#
#  id                 :integer          not null, primary key
#  starting_weight_id :integer
#  program_id         :integer
#  cycle_number       :integer
#  created_at         :datetime
#  updated_at         :datetime
#  active             :boolean
#

require 'rails_helper'

describe Cycle do
  let(:cycle) { FactoryGirl.create(:cycle) }
  let!(:finished_cycles) { FactoryGirl.create_list(:cycle, 2, :with_finished_subcycles)}
  let!(:unfinished_cycle) { FactoryGirl.create(:cycle, :with_unfinished_subcycle)}

  describe "cycle number" do
    context "when not present" do
      before { cycle.cycle_number = 'cat' }

      it "is not valid" do
        expect(cycle).not_to be_valid
      end
    end

    context "when not a number" do
      before { cycle.cycle_number = 'cat' }

      it "is not valid" do
        expect(cycle).not_to be_valid
      end
    end
  end

  describe ".finished?" do
    context "when all of its subcycles are finished" do
      it "is returns true" do
        finished_cycle = finished_cycles[0]
        expect(finished_cycle.finished?).to be_truthy
      end
    end

    context "when it has an unfinished subcycle" do
      it "is returns false" do
        expect(unfinished_cycle.finished?).to be_falsey
      end
    end
  end

  describe "#recent_workout_completion" do
    before do
      Cycle.all.each { |c| c.delete }
    end
    let!(:workout_newest) { FactoryGirl.create(:workout, workout_date: '2014-12-06') }
    let!(:workout_oldest) { FactoryGirl.create(:workout, workout_date: '2014-12-04') }
    let!(:workout_middle) { FactoryGirl.create(:workout, workout_date: '2014-12-05') }

    it "return cycles in order of their most recently completed workout" do
      expected_order = [
        workout_newest.subcycle.cycle,
        workout_middle.subcycle.cycle,
        workout_oldest.subcycle.cycle
      ]

      expect(Cycle.recent_workout_completion).to eq expected_order
    end
  end

  it "is active on initialization" do
    cycle = Cycle.new
    cycle.save
    expect(cycle.active?).to be_truthy
  end

  describe "#finished" do
    it "returns finished cycles" do
      expect(Cycle.finished).to eq finished_cycles
    end

    it "does not return unfinished cycles" do
      expect(Cycle.finished).not_to include unfinished_cycle
    end
  end

  describe "#unfinished" do
    it "returns the unfinished cycles" do
      expect(Cycle.unfinished).to include unfinished_cycle
    end

    it "does not include the finished cycles" do
      expect(Cycle.unfinished).not_to include finished_cycles
    end
  end

  describe "#active" do
    let!(:inactive_cycle) { FactoryGirl.create(:cycle, active: false) }
    let!(:active_cycle) { FactoryGirl.create(:cycle, active: true) }

    it "includes active programs" do
      expect(Cycle.active).to include active_cycle
    end

    it "does not include inactive programs" do
      expect(Cycle.active).not_to include inactive_cycle
    end
  end

  describe ".next_workout" do

    context "when it has multiple incomplete workouts" do
      let(:subcycle) {FactoryGirl.create(:subcycle, cycle: cycle) }
      let!(:workout) {FactoryGirl.create(:workout, subcycle: subcycle, id: 2) }
      let!(:newer_workout) {FactoryGirl.create(:workout, subcycle: subcycle, id: 3) }

      it "returns the next workout with the lowest id" do
        expect(cycle.next_workout).to eq workout
      end
    end

    context "when it does not have incomplete workouts" do
      it "returns nil" do
        finished_cycle = finished_cycles[0]
        expect(finished_cycle.next_workout).to be_nil
      end
    end
  end

  describe ".cycle_weights_hash" do
    it "returns a hash of cycle weight exercise names paired to their values" do
      cycle = FactoryGirl.create(:cycle,
                                 :with_cycle_weight_name_and_values,
                                 cycle_weight_pairs: [[:bro_up, 70], [:pull_up, 60]]
                                )
      expect(cycle.cycle_weights_hash).to eq({:bro_up => 70, :pull_up => 60})
    end
  end
end
