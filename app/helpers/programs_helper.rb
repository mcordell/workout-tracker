module ProgramsHelper
  def current_cycle(program)
    if @program.current_cycle
      link_to "Current Cycle", program_cycle_path(@program, @program.current_cycle), class: "btn btn-lg btn-success btn-block"
    else
      link_to "Create Cycle", new_program_cycle_path(@program), class: "btn btn-lg btn-success btn-block"
    end
  end
end
