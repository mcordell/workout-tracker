class ExercisesController < ApplicationController
  load_and_authorize_resource param_method: :exercise_params

  # GET /exercises
  def index
    @exercises = Exercise.all
  end

  # GET /exercises/1
  def show
  end

  # GET /exercises/new
  def new
    @exercise = Exercise.new
  end

  # GET /exercises/1/edit
  def edit
  end

  # POST /exercises
  def create
    @exercise = Exercise.new(exercise_params)

    if @exercise.save
      redirect_to @exercise, notice: 'Exercise was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /exercises/1
  def update
    if @exercise.update(exercise_params)
      redirect_to @exercise, notice: 'Exercise was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /exercises/1
  def destroy
    @exercise.destroy
    redirect_to exercises_url, notice: 'Exercise was successfully destroyed.'
  end

  private
    # Only allow a trusted parameter "white list" through.
    def exercise_params
      params.require(:exercise).permit(:name)
    end
end
