require 'rails_helper'

RSpec.describe "Doing a workout", type: :request do
  let(:workout) { FactoryGirl.create(:workout) }
  let(:do_workout_page) { DoWorkoutPage.new(workout) }

  context "when logged in" do
    before do
      login valid_user('test@email.com', 'password')
    end

    feature "visiting the do workout path" do
      it "has the column headers" do
        do_workout_page.goto
        expect(do_workout_page).to have_column_headers
      end

      context "with valid workoutsets" do
        before do
          exercise_weight = FactoryGirl.create(:exercise_weight, exercise_name: 'Press')
          exercise_weight2 = FactoryGirl.create(:exercise_weight, exercise_name: 'Press')
          FactoryGirl.create(:workout_set, workout: workout, intended_reps: 4, weight: 185, exercise_weight: exercise_weight)
          FactoryGirl.create(:workout_set, workout: workout, intended_reps: 7, weight: 198, exercise_weight: exercise_weight2)
        end

        it "has the exercise names of the work out sets" do
          do_workout_page.goto
          expect(do_workout_page).to have_set_row("Press", 4, 185)
          expect(do_workout_page).to have_set_row("Press", 7, 198)
        end
      end
    end
  end
end
