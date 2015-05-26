class Exercise::Cell < Cell::Concept
  property :display_name

  def show
    render
  end

  private

  def edit_link
    link_to 'Edit', edit_exercise_path(model)
  end

  def all_exercises_link
    link_to 'All', exercises_path
  end
end
