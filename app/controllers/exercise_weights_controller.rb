class ExerciseWeightsController < ApplicationController
  load_and_authorize_resource param_method: :exercise_weight_params

  def index
    @exercise_weights = ExerciseWeight.all
  end

  def show
  end

  def new
    @exercise_weight = ExerciseWeight.new
  end

  def edit
  end

  def create
    @exercise_weight = ExerciseWeight.new(exercise_weight_params)

    if @exercise_weight.save
      redirect_to @exercise_weight, notice: 'Weight was successfully created.'
    else
      render :new
    end
  end

  def update
    if @exercise_weight.update(exercise_weight_params)
      redirect_to @exercise_weight, notice: 'Weight was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @exercise_weight.destroy
    redirect_to exercise_weights_url, notice: 'Weight was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_exercise_weight
      @exercise_weight = ExerciseWeight.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def exercise_weight_params
      params.require(:exercise_weight).permit(:value, :unit)
    end
end
