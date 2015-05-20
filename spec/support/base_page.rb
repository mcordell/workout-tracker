class BasePage
  include Capybara::DSL
  include Rails.application.routes.url_helpers

  DEFAULT_ALERT_CLASS = 'alert'

  def goto
    visit(page_path)
  end

  def page_path
    root_path
  end

  def has_alert?(message, alert_class = nil)
    alert_class ||= DEFAULT_ALERT_CLASS
    has_css? ".#{alert_class}", text: message
  end

  def has_logout_button?
    has_link? 'Sign Out', href: destroy_user_session_path
  end

  def has_login_button?
    has_link? 'Sign In', href: new_user_session_path
  end

  def has_form_errors?
    has_css? 'div#error_explanation'
  end

  def driver
    page.driver
  end
end
