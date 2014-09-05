class CyclesController < ApplicationController
  load_and_authorize_resource param_method: :cycle_params

  def index
    @cycles = Cycle.all
  end

  def show
  end

  def new
    @program = Program.find(params[:program_id])
    @cycle = Cycle.new
    @cycle.cycle_number = @program.cycles.count
    @start_weight = Weight.new
  end

  def edit
  end

  def create
    @program = Program.find(params[:program_id])
    weight = Weight.new(params.require(:cycle).require(:weight).permit(:value))
    @cycle = @program.cycles.build()
    @cycle.active = true
    @cycle.starting_weight = weight

    if @cycle.save
      redirect_to [@program, @cycle], notice: 'Cycle was successfully created.'
    else
      render :new
    end
  end

  def update
    if @cycle.update(cycle_params)
      redirect_to @cycle, notice: 'Cycle was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @cycle.destroy
    redirect_to cycles_url, notice: 'Cycle was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_cycle
      @cycle = Cycle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def cycle_params
      params.require(:cycle).permit(:cycle_number)
    end
end
