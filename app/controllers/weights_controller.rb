class WeightsController < ApplicationController
  load_and_authorize_resource param_method: :weight_params

  def index
    @weights = Weight.all
  end

  def show
  end

  def new
    @weight = Weight.new
  end

  def edit
  end

  def create
    @weight = Weight.new(weight_params)

    if @weight.save
      redirect_to @weight, notice: 'Weight was successfully created.'
    else
      render :new
    end
  end

  def update
    if @weight.update(weight_params)
      redirect_to @weight, notice: 'Weight was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @weight.destroy
    redirect_to weights_url, notice: 'Weight was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weight
      @weight = Weight.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def weight_params
      params.require(:weight).permit(:value, :unit)
    end
end
