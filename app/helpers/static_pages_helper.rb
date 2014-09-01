module StaticPagesHelper
  def current_program(user)
    if user.current_program
      "<strong>Current Program:</strong> #{user.current_program.name}"
    else
      link_to "Create a new program", new_user_program_path(user)
    end
  end
end
