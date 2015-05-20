class ExerciseEditPage < BasePage
  attr_reader :exercise

  UPDATE_SUCCESSFUL = 'Exercise was successfully updated.'

  def initialize(exercise)
    @exercise = exercise
  end

  def page_path
    edit_exercise_path(@exercise)
  end

  def fill_exercise_name(name)
    fill_in('Name', with: name)
  end

  def has_current_exercise_display_name?
    find_field('Name').value == exercise.display_name
  end

  def has_update_successful_message?
    has_alert? UPDATE_SUCCESSFUL
  end

  def submit
    click_on('Update Exercise')
  end
end
