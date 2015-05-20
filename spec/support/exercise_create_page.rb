class ExerciseCreatePage < BasePage
  CREATE_SUCCESSFUL = 'Exercise was successfully created.'

  def page_path
    new_exercise_path
  end

  def fill_exercise_name(name)
    fill_in('Name', with: name)
  end

  def has_create_successful_message?
    has_alert? CREATE_SUCCESSFUL
  end

  def has_proper_placeholders?
    find_field('Name')['placeholder'] == 'Exercise Name'
  end

  def submit
    click_on('Create Exercise')
  end
end
