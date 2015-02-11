class WorkoutSetsController < ApplicationController
  load_and_authorize_resource param_method: :workout_set_params

  def index
    @workout_sets = WorkoutSet.all
  end

  def show
  end

  def new
    @workout_set = WorkoutSet.new
  end

  def edit
  end

  def create
    @workout_set = WorkoutSet.new(workout_set_params)

    if @workout_set.save
      redirect_to @workout_set, notice: 'Workout set was successfully created.'
    else
      render :new
    end
  end

  def update
    if @workout_set.update(workout_set_params)
      redirect_to @workout_set, notice: 'Workout set was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @workout_set.destroy
    redirect_to workout_sets_url, notice: 'Workout set was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workout_set
      @workout_set = WorkoutSet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def workout_set_params
      params.require(:workout_set).permit(:exercise_id, :workout, :intended_reps, :weight, :performed_reps)
    end
end
