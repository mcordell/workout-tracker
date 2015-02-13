class CyclesController < ApplicationController
  load_and_authorize_resource param_method: :cycle_params

  def index
    @cycles = Cycle.all
  end

  def show
  end

  def new
    program = Program.find(params[:program_id])
    @previous_cycle = Program.find(params[:program_id]).cycles.order(:created_at).last
    @cycle = program.cycles.build
    @cycle.cycle_number = @previous_cycle.cycle_number + 1 if @previous_cycle
    @cycle.build_starting_weight
    CycleCreator.add_starting_weights(@cycle)
  end

  def edit
  end

  def create
    program = Program.find(params[:program_id])
    @cycle = program.cycles.build(cycle_params.merge({active: true}))
    @cycle.starting_weight.user = current_user
    @cycle = CycleCreator.create(@cycle)
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
      params.require(:cycle).permit(:cycle_number,
                                    starting_weight_attributes: [:value, :id],
                                    cycle_weights_attributes: [exercise_weight_attributes: [:id, :value, :weightable_id, :weightable_type]])
    end
end
