# == Schema Information
#
# Table name: workout_sets
#
#  id             :integer          not null, primary key
#  exercise_id    :integer
#  workout_id     :integer
#  intended_reps  :integer
#  weight         :integer
#  performed_reps :integer
#  created_at     :datetime
#  updated_at     :datetime
#  options        :text
#  weight_id      :integer
#

require 'rails_helper'

describe WorkoutSet do
  let(:workout_set) { FactoryGirl.build(:workout_set) }

  describe ".rep_difference" do
    describe "when the performed reps is more than the intended" do
      let(:workout_set) { FactoryGirl.build(:workout_set, intended_reps: 6, performed_reps: 7) }

      it "returns a positive number for the difference" do
        expect(workout_set.rep_difference).to eq 1
      end
    end

    describe "when the performed reps is less than the intended" do
      let(:workout_set) { FactoryGirl.build(:workout_set, intended_reps: 6, performed_reps: 5) }

      it "returns a negative number for the difference" do
        expect(workout_set.rep_difference).to eq -1
      end
    end

    describe "when performed reps is not present" do
      let(:workout_set) { FactoryGirl.build(:workout_set, intended_reps: 6, performed_reps: nil) }

      it "return nil" do
        expect(workout_set.rep_difference).to be_nil
      end
    end
  end

  describe ".assign_reps" do
    context "when passed a positive integer" do
      before { workout_set.assign_reps(7) }

      it "sets intended_reps to that number" do
        expect(workout_set.intended_reps).to be 7
      end
    end

    context "when passed a string with a number and a plus" do
      before { workout_set.assign_reps("6+") }

      it "sets intended_reps to that number" do
        expect(workout_set.intended_reps).to be 6
      end

      it "makes :plus_set to its options" do
        expect(workout_set.options).to include :plus_set
      end
    end

    context "when passed a negative integer" do
      it "raises an exception" do
        expect { workout_set.assign_reps(-5)  }.to raise_exception
      end
    end

    context "when passed a string where a number is prepended with a negative sign" do
      it "raises an exception" do
        expect { workout_set.assign_reps("-6+")  }.to raise_exception
      end
    end
  end

  describe "plus_set?" do
    context "when options contains :plus_set" do
      before { workout_set.options = [:plus_set] }

      it "is returns true" do
        expect(workout_set.plus_set?).to be_truthy
      end
    end

    context "when options does not include :plus_set" do
      before { workout_set.options = [] }

      it "is returns false" do
        expect(workout_set.plus_set?).to be_falsey
      end
    end
  end

  describe "delegate methods" do
    let(:program) { FactoryGirl.create(:program) }
    let(:cycle) { FactoryGirl.create(:cycle, program: program) }
    let(:subcycle) { FactoryGirl.create(:subcycle, cycle: cycle) }
    let(:workout) { FactoryGirl.create(:workout, subcycle: subcycle) }
    let(:exercise_name) { 'Push up' }
    let(:weight) { FactoryGirl.create(:exercise_weight, exercise_name: exercise_name) }
    let(:workout_set) { FactoryGirl.create(:workout_set, workout: workout, weight: weight) }

    describe ".program" do
      it "returns the program this workout belongs to"  do
        expect(workout_set.program).to eq program
      end
    end

    describe ".cycle" do
      it "returns the program this workout belongs to"  do
        expect(workout_set.cycle).to eq cycle
      end
    end

    describe ".subcycle" do
      it "returns the program this workout belongs to"  do
        expect(workout_set.subcycle).to eq subcycle
      end
    end

    describe ".name" do
      it "returns the name of the associated weight" do
        expect(workout_set.name).to eq exercise_name
      end
    end
  end
end
