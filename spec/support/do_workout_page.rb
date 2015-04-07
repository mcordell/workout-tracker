class DoWorkoutPage < BasePage
  attr_accessor :workout

  def initialize(workout)
    @workout = workout
  end

  def page_path
    doworkout_path(workout)
  end

  def has_column_headers?
    has_css?('th', text: 'Exercise') &&
    has_css?('th', text: 'Reps') &&
    has_css?('th', text: 'Weight')
  end

  def has_set_row?(name, intended_reps, weight)
    has_xpath?(".//tr[.//td/input[@value='#{intended_reps}']][.//td[text()='#{name}']][.//td[text()='#{weight}']]")
  end

  def has_quick_add_button?
    save_and_open_page
    has_css?('button .quick-add')
  end

  def click_quick_add_button
    find("button.quick-add", match: :first).click
  end

  def has_quick_add_row?
    has_css?("tr.quick-add")
  end

  def fill_quick_add_row(row, exercise, reps, weight)
    row.select(exercise)
    row.find('input[id$="performed_reps"]').set(reps)
    row.find('input[id$="weight"]').set(weight)
  end

  def submit
    click_on('Update Workout')
  end

  def updated_successfully?
    find('div.alert').has_text? 'Workout was successfully updated.'
  end
end
