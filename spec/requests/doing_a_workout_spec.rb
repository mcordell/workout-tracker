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

    feature "clicking the quick add button", js: true do
      let(:workout) { FactoryGirl.create(:workout) }
      let(:do_workout_page) { DoWorkoutPage.new(workout) }

      before do
        FactoryGirl.create(:exercise, name: 'Press')
        FactoryGirl.create(:exercise, name: 'Deadlift')
        do_workout_page.goto
        do_workout_page.click_quick_add_button
      end

      it "does not change the current page" do
        expect(current_path).to eq do_workout_page.page_path
      end

      it "adds the quick add row" do
        expect(do_workout_page).to have_quick_add_row
      end

      feature "adding a set via the quick add row and clicking submit" do
        before do
          @before_count = workout.workout_sets.count
          row = find('tr.quick-add')
          do_workout_page.fill_quick_add_row(row, 'Deadlift', 5, 400)
          do_workout_page.submit
        end

        it "redirects to the workout" do
          expect(current_path).to eq workout_path(workout)
        end

        it "displays a notice that the workout was updated successfully" do
          expect(do_workout_page).to be_updated_successfully
        end

        it "adds the set to the workout" do
          expect(do_workout_page).to be_updated_successfully
          new_set = workout.workout_sets.last
          expect(new_set.performed_reps).to eq 5
          expect(new_set.exercise_weight.value).to eq 400
          expect(new_set.exercise_weight.name).to eq 'Deadlift'
        end

        it "adds one new workout set" do
          expect(do_workout_page).to be_updated_successfully
          expect(workout.workout_sets.count).to eq @before_count + 1
        end
      end

      feature "adding a set via the quick add row without reps" do
        before do
          row = find('tr.quick-add')
          do_workout_page.fill_quick_add_row(row, 'Deadlift', '', 400)
          do_workout_page.submit
        end

        it "re-renders the do workout page" do
          expect(do_workout_page).to have_column_headers
        end

        it "displays an error" do
          expect(do_workout_page).to have_errors
        end
      end
    end
  end

  context 'when not logged in' do
    feature "visiting the do workout page" do
      it "redirects to the home page" do
        do_workout_page.goto
        expect(current_path).to eq root_path
      end
    end

    feature "PUTing to the workout update" do
      let(:driver) { BasePage.new.driver }
      before do
        driver.put doworkout_path(workout), { workout: { workout_date: Time.now } }
      end

      it "does not change the exercise" do
        expect {
          workout.reload
        }.not_to change { workout.workout_date }
      end

      it "redirects" do
        expect(driver.response.status).to eq 302
      end
    end
  end
end
