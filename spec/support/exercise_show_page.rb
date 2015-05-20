class ExerciseShowPage < BasePage
  attr_reader :exercise

  def initialize(exercise)
    @exercise = exercise
  end

  def page_path
    exercise_path(@exercise)
  end

  def has_the_show_header?
    has_css? 'h1', text: 'Show'
  end

  def has_the_exercise_name?
    has_css? 'p', text: exercise.display_name
  end
end
