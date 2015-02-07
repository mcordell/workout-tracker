class LoginPage < BasePage

  LOGIN_PROMPT_TEXT = 'Sign in'
  SUBMIT_BUTTON = 'Sign in'
  BAD_LOGIN_WARNING = 'Invalid email address or password.'

  def page_path
    new_user_session_path
  end

  def has_bad_login_warning?
    has_alert? BAD_LOGIN_WARNING, 'alert-danger'
  end

  def has_login_prompt?
    has_css?('h2', text: LOGIN_PROMPT_TEXT)
  end

  def fill_username(username)
    fill_in('Email', with: username)
  end

  def fill_password(password)
    fill_in('Password', with: password)
  end

  def submit
    find_button(SUBMIT_BUTTON).click
  end

  def login(username, password)
    goto
    fill_username username
    fill_password password
    submit
  end
end
