class WorkoutsController < ApplicationController
  load_and_authorize_resource param_method: :workout_params, except: [:update]
  include Trailblazer::Operation::Controller
  require 'trailblazer/operation/controller/active_record'
  include Trailblazer::Operation::Controller::ActiveRecord
  respond_to :html
  before_filter :load_current_user_into_params, only: [:workout, :doworkout]

  def index
    @workouts = Workout.all
  end

  def show
  end

  def new
    @workout = Workout.new
  end

  def edit
  end

  def create
    @workout = Workout.new(workout_params)

    if @workout.save
      redirect_to @workout, notice: 'Workout was successfully created.'
    else
      render :new
    end
  end

  def workout
   form Workout::DoWorkout
  end

  def update
    if @workout.update(workout_params)
      redirect_to @workout, notice: 'Workout was successfully updated.'
    else
      render :edit
    end
  end

  def doworkout
    run Workout::DoWorkout do |op|
      return redirect_to op.model, notice: 'Workout was successfully updated.'
    end

    render :workout
  end

  def destroy
    @workout.destroy
    redirect_to workouts_url, notice: 'Workout was successfully destroyed.'
  end

  private

  def load_current_user_into_params
    params.merge!(current_user: current_user)
  end

  # Use callbacks to share common setup or constraints between actions.
  def set_workout
    @workout = Workout.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def workout_params
    params.require(:workout).permit(:subcycle_id, :workout_date, :notes, workout_sets_attributes: [:performed_reps, :id])
  end
end
