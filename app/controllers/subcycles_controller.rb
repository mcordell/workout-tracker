class SubcyclesController < ApplicationController
  load_and_authorize_resource param_method: :subcycle_params

  def index
    @subcycles = Subcycle.all
  end

  def show
  end

  def new
    @subcycle = Subcycle.new
  end

  def edit
  end

  def create
    @subcycle = Subcycle.new(subcycle_params)

    if @subcycle.save
      redirect_to @subcycle, notice: 'Subcycle was successfully created.'
    else
      render :new
    end
  end

  def update
    if @subcycle.update(subcycle_params)
      redirect_to @subcycle, notice: 'Subcycle was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @subcycle.destroy
    redirect_to subcycles_url, notice: 'Subcycle was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_subcycle
      @subcycle = Subcycle.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def subcycle_params
      params.require(:subcycle).permit(:cycle, :number)
    end
end
