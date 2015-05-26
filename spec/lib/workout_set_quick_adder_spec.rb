require 'rails_helper'

describe WorkoutSetQuickAdder do
  let(:exercise_one) { FactoryGirl.create(:exercise) }
  let(:exercise_two) { FactoryGirl.create(:exercise) }
  let(:test_params) {
   {"0" => {"exercise_id"=>"#{exercise_one.id}", "performed_reps"=>"2", "weight"=>"150"},
    "1"=>{"exercise_id"=>"#{exercise_two.id}", "performed_reps"=>"200", "weight"=>"400"},
    "new_set_id"=>{"exercise_id"=>"1", "performed_reps"=>"", "weights"=>""}}
  }

  describe "adding sets to the workout" do
    let!(:workout) { FactoryGirl.create(:workout) }

    context "with valid parameters" do
      let(:workout_set_quick_adder) { WorkoutSetQuickAdder.new(test_params) }

      before do
         workout_set_quick_adder.add_sets_to_workout(workout)
         @first = workout.workout_sets[0]
      end

      it "adds two workout sets to the workout" do
        this_workout = FactoryGirl.create(:workout)
        expect { workout_set_quick_adder.add_sets_to_workout(this_workout) }.
          to change(this_workout.workout_sets, :length).by(2)
      end

      it "adds the first set with proper exercise" do
         expect(@first.exercise_weight.exercise_id).to eq exercise_one.id
      end

      it "adds the first set with proper weight" do
         expect(@first.exercise_weight.value).to eq 150
      end

      it "adds the first set with proper performed reps" do
         expect(@first.performed_reps).to eq 2
      end
    end

    context "with nil params" do
      let(:workout_set_quick_adder) { WorkoutSetQuickAdder.new(nil) }
      it "does not add sets to the workout" do
        expect { workout_set_quick_adder.add_sets_to_workout(workout) }
          .not_to change(workout.workout_sets, :length)
      end
    end
  end
end
