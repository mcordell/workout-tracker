require 'rails_helper'

RSpec.describe "managing exercises", type: :request do
  let(:exercise_page) { ExercisePage.new }

  context "when logged in" do
    before do
      login valid_user('test@email.com', 'password')
    end

    feature "visiting the list of exercises" do
      let(:exercise_names) { %w{ Deadlift Squat} }

      before do
        @press_exercise = FactoryGirl.create(:exercise, display_name: 'Press')
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
          exercise_page.click_delete_exercise("Press")
          expect(Exercise.find_by_name("Press")).to be_nil
        end
      end

      feature "going to edit an exercise" do
        it "goes to the edit page for the exercise" do
          exercise_page.click_edit_exercise('Press')
          expect(current_path).to eq edit_exercise_path(@press_exercise)
        end
      end

      feature "going to show an exercise" do
        it "goes to the show page for the exercise" do
          exercise_page.click_show_exercise('Press')
          expect(current_path).to eq exercise_path(@press_exercise)
        end
      end
    end
  end
end
