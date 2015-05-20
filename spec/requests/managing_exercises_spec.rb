require 'rails_helper'

RSpec.describe "managing exercises", type: :request do
  let!(:press_exercise) { FactoryGirl.create(:exercise, display_name: 'Press') }

  context "when logged in" do
    before do
      login valid_user('test@email.com', 'password')
    end

    feature "visiting the list of exercises" do
      let(:exercise_names) { %w{ Deadlift Squat} }
      let(:exercise_page) { ExerciseListPage.new }

      before do
        exercise_names.each { |e| FactoryGirl.create(:exercise, display_name: e) }
        exercise_page.goto
      end

      it "lists all of the exercise names with admin links" do
        exercise_names.each do |name|
          expect(exercise_page).to have_exercise_name(name)
        end
      end

      feature "deleting a exercise" do
        it "deletes the exercise" do
          expect {
            exercise_page.click_delete_exercise("Press")
          }.to change { Exercise.find_by_name("press") }
        end
      end

      feature "going to edit an exercise" do
        it "goes to the edit page for the exercise" do
          exercise_page.click_edit_exercise('Press')
          expect(current_path).to eq edit_exercise_path(press_exercise)
        end
      end

      feature "going to show an exercise" do
        it "goes to the show page for the exercise" do
          exercise_page.click_show_exercise('Press')
          expect(current_path).to eq exercise_path(press_exercise)
        end
      end
    end

    feature "showing an exercise" do
      let(:exercise_page) { ExerciseShowPage.new(press_exercise) }

      before { exercise_page.goto }

      it "shows the name of the exercise" do
        expect(exercise_page).to have_the_exercise_name
      end

      it "has the show header" do
        expect(exercise_page).to have_the_show_header
      end
    end

    feature "visiting the edit page" do
      let(:exercise_page) { ExerciseEditPage.new(press_exercise) }

      before { exercise_page.goto }

      it "has the current exercise name in the input box" do
        expect(exercise_page).to have_current_exercise_display_name
      end

      feature "submitting a name change" do
        before do
          exercise_page.fill_exercise_name 'Overhead press'
          exercise_page.submit
        end

        it "changes the exercise name" do
          press_exercise.reload
          expect(press_exercise.name).to eq 'overhead_press'
        end

        it "has the update banner" do
          expect(exercise_page).to have_update_successful_message
        end
      end

      feature "submitting a blank name change" do
        before do
          exercise_page.fill_exercise_name ''
          exercise_page.submit
        end

        it "does not change the exercise name" do
          press_exercise.reload
          expect(press_exercise.name).to eq 'press'
        end

        it "has errors" do
          expect(exercise_page).to have_form_errors
        end
      end
    end

    feature "visiting the new exercise page" do
      let(:exercise_page) { ExerciseCreatePage.new }
      let!(:pre_exercise_count) { Exercise.count }

      before { exercise_page.goto }

      it "has proper placeholders" do
        expect(exercise_page).to have_proper_placeholders
      end

      feature "submitting a valid exercise name" do
        before do
          exercise_page.fill_exercise_name 'Overhead press'
          exercise_page.submit
        end

        it "creates an exercise" do
          expect(Exercise.count).to eq pre_exercise_count + 1
        end

        it "has the create banner" do
          expect(exercise_page).to have_create_successful_message
        end
      end

      feature "submitting a blank name change" do
        before do
          exercise_page.fill_exercise_name ''
          exercise_page.submit
        end

        it "does not create an exercise" do
          expect(Exercise.count).to eq pre_exercise_count
        end

        it "has errors" do
          expect(exercise_page).to have_form_errors
        end
      end
    end
  end

  context "when not logged in" do
    let(:driver) { BasePage.new.driver }

    feature "visting the list page" do
      let(:exercise_page) { ExerciseListPage.new }
      it "redirects to the sign in page" do
        exercise_page.goto
        expect(current_path).to eq new_user_session_path
      end
    end

    feature "visting the show page for an existing exercise" do
      let(:exercise_page) { ExerciseShowPage.new(press_exercise) }
      it "redirects to the sign in page" do
        exercise_page.goto
        expect(current_path).to eq new_user_session_path
      end
    end

    feature "POSTing to the create URL" do
      it "does not create an exercise" do
        expect {
          driver.post '/exercises', { exercise: { display_name: 'Something' } }
        }.not_to change{ Exercise.count }
      end
    end

    feature "PUTing to an existing exercise" do
      it "does not change the exercise" do
        driver.put exercise_path(press_exercise), { exercise: { display_name: 'Something' } }
        press_exercise.reload
        expect(press_exercise.display_name).not_to eq('Something')
      end
    end

    feature "DELETEing an existing exercise" do
      it "does not change the exercise" do
        expect {
          driver.delete exercise_path(press_exercise)
        }.not_to change{ Exercise.count }
      end
    end
  end
end
