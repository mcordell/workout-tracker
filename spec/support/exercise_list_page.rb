class ExerciseListPage < BasePage
  SHOW_ICON = 'glyphicon-eye-open'
  EDIT_ICON = 'glyphicon-pencil'
  DELETE_ICON = 'glyphicon-trash'

  def page_path
    exercises_path
  end

  def has_exercise_name?(name)
    has_css? 'td', text: name
  end

  def click_delete_exercise(exercise_name)
    click_icon_in_row(exercise_name, DELETE_ICON)
  end

  def click_edit_exercise(exercise_name)
    click_icon_in_row(exercise_name, EDIT_ICON)
  end

  def click_show_exercise(exercise_name)
    click_icon_in_row(exercise_name, SHOW_ICON)
  end

  def click_icon_in_row(exercise_name, icon_class)
    row = find(:xpath, "//tr[.//td[text()='#{exercise_name}']]")
    row.find(:xpath, 'td/a[contains(concat(" ", normalize-space(@class), " "), " ' + icon_class + ' ")]').click
  end
end
