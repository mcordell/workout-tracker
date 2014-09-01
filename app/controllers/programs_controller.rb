class ProgramsController < ApplicationController
  load_and_authorize_resource param_method: :program_params

  def index
    @programs = Program.all
  end

  def show
  end

  def new
    @program = Program.new
  end

  def edit
  end

  def create
    user = User.find(params[:user_id])
    @program = user.programs.build(program_params)

    if @program.save
      redirect_to user_program_path(user, @program), notice: 'Program was successfully created.'
    else
      render :new
    end
  end

  def update
    if @program.update(program_params)
      redirect_to @program, notice: 'Program was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @program.destroy
    redirect_to programs_url, notice: 'Program was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_program
      @program = Program.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def program_params
      params.require(:program).permit(:name, :user)
    end
end
