class HomePage < BasePage
  def page_path
    root_path
  end

  def has_programs_link?
    has_link? 'Programs', href: programs_path
  end
end
