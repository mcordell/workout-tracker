class LoginPage < BasePage

  LOGIN_PROMPT_TEXT = 'Sign in'

  def page_path
    new_user_session_path
  end

  def has_login_prompt?
    has_css?('h2', text: LOGIN_PROMPT_TEXT)
  end
end
