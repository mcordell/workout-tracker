# == Schema Information
#
# Table name: subcycles
#
#  id         :integer          not null, primary key
#  cycle_id   :integer
#  number     :integer
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe Subcycle do

  describe ".program" do
    let(:program) { FactoryGirl.create(:program) }
    let(:cycle) { FactoryGirl.create(:cycle, program: program) }

    it "returns the program this subcycle belongs to"  do
      subcycle = FactoryGirl.create(:subcycle, cycle: cycle)
      expect(subcycle.program).to eq program
    end
  end

  describe ".finished?" do
    context "when it has incomplete workouts"  do
      let(:subcycle_with_incomplete_workouts) { FactoryGirl.create(:subcycle, :with_not_completed_workouts) }

      it "returns false" do
        expect(subcycle_with_incomplete_workouts).not_to be_finished
      end
    end

    context "when it has complete workouts"  do
      let(:subcycle_with_complete_workouts) { FactoryGirl.create(:subcycle, :with_completed_workouts) }

      it "returns false" do
        expect(subcycle_with_complete_workouts).to be_finished
      end
    end
  end

  describe ".from_hash" do
    let(:subcycle) { Subcycle.new }

    it "does not change the workout count when passed an empty hash" do
      expect{subcycle.from_hash({})}.to change{subcycle.workouts.to_a.count}.by 0
    end

    context "when passed a hash two workout hashes and the number value set" do
      let(:valid_hash) { {number: 4, workouts:[ {}, {} ]} }

      it "creates two workout on the cycle" do
        expect{subcycle.from_hash(valid_hash)}.to change{subcycle.workouts.to_a.count}.by 2
      end

      it "sets the number attribute" do
        subcycle.from_hash(valid_hash)
        expect(subcycle.number).to be 4
      end
    end
  end
end
