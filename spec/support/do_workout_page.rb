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
end
