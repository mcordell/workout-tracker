class BasePage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  def goto
    visit(page_path)
  end

  def page_path
    root_path
  end
end
