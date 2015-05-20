class ExercisesController < ApplicationController
  include Trailblazer::Operation::Controller
  require 'trailblazer/operation/controller/active_record'
  include Trailblazer::Operation::Controller::ActiveRecord
  respond_to :html

  def index
    throw(:warden) unless current_user
    @exercises = Exercise.all
  end

  def show
    present Exercise::Update
  end

  def new
    form Exercise::Create
  end

  def edit
    form Exercise::Update
    render :new
  end

  def create
    run Exercise::Create do |op|
      return redirect_to op.model, notice: 'Exercise was successfully created.'
    end

    render :new
  end

  def update
    run Exercise::Update do |op|
      return redirect_to op.model, notice: 'Exercise was successfully updated.'
    end

    render :new
  end

  def destroy
    run Exercise::Delete do
      redirect_to exercises_url, notice: 'Exercise was successfully destroyed.'
    end
  end

  def params
    super.merge(current_user: current_user)
  end
end
