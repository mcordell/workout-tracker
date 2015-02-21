# == Schema Information
#
# Table name: workouts
#
#  id           :integer          not null, primary key
#  subcycle_id  :integer
#  workout_date :datetime
#  notes        :text
#  created_at   :datetime
#  updated_at   :datetime
#

require 'rails_helper'

describe Workout do

  describe "#incomplete" do
    let!(:incomplete_workouts) { FactoryGirl.create(:workout, :not_completed) }
    let!(:complete_workouts) { FactoryGirl.create(:workout, :completed) }

    it "includes workouts that are incomplete" do
      expect(Workout.incomplete).to include incomplete_workouts
    end

    it "does not include workouts that are complete" do
      expect(Workout.incomplete).not_to include complete_workouts
    end
  end

  describe "from_hash" do
    let(:workout) { Workout.new }

    context "when passed an empty hash" do
      it "does not change attributes" do
        workout.workout_date = '2015/12/02'
        expect{workout.from_hash({})}.not_to change(workout, :workout_date)
      end

      it "does not add workout sets" do
        expect{workout.from_hash({})}.not_to change(workout.workout_sets.to_a, :count)
      end
    end

    context "when passed a valid hash" do
      let(:valid_hash) { {workout_date: '2015/12/02', workout_sets: [{}, {}]}}

      it "sets attributes" do
        workout.from_hash(valid_hash)
        expect(workout.workout_date).to eq '2015/12/02'
      end

      it "adds two workout sets" do
        expect{workout.from_hash(valid_hash)}.to change{ workout.workout_sets.to_a.count }.by 2
      end
    end

    context "when passed a hash where sets are refered to as 'sets'" do
      let(:valid_hash) { {workout_date: '2015/12/02', sets: [{}, {}]}}

      it "adds two workout sets" do
        expect{workout.from_hash(valid_hash)}.to change{ workout.workout_sets.to_a.count }.by 2
      end
    end
  end

  describe "delegate methods" do
    let(:program) { FactoryGirl.create(:program) }
    let(:cycle) { FactoryGirl.create(:cycle, program: program) }
    let(:subcycle) { FactoryGirl.create(:subcycle, cycle: cycle) }
    let(:this_workout) { FactoryGirl.create(:workout, subcycle: subcycle) }

    describe ".program" do
      it "returns the program this workout belongs to"  do
        expect(this_workout.program).to eq program
      end
    end

    describe ".cycle" do
      it "returns the program this workout belongs to"  do
        expect(this_workout.cycle).to eq cycle
      end
    end
  end
end
