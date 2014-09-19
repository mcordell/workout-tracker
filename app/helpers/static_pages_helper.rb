module StaticPagesHelper
  def current_program(user)
    if user.current_program
      link_to user.current_program.name, program_path(user.current_program)
    else
      link_to "Create a new program", new_program_path(user)
    end
  end
end
