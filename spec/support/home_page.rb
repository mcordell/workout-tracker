class HomePage < BasePage
  def page_path
    root_path
  end

  def has_programs_link?
    has_link? 'Programs', href: programs_path
  end

  def has_exercises_link?
    has_link? 'Exercises', href: exercises_path
  end
end
