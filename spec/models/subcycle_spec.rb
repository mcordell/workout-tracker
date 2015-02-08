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
end
