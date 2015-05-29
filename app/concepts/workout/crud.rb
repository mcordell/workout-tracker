class Workout < ActiveRecord::Base
  class DoWorkout < Trailblazer::Operation
    include CRUD

    model Workout, :update

    builds ->(params) {
      throw(:warden) unless params[:current_user]
    }

    contract do
      property :notes

      collection :workout_sets do
        property :performed_reps
        validates :performed_reps, numericality: true

        property :intended_reps, writable: false

        delegate :display_name, to: :model

        property :exercise_weight do
          property :value
        end
      end
    end

    def process(params)
      validate(params[:workout]) do |f|
        f.save
      end
    end

    private

    def update_model(params)
      self.class.model_class.includes(workout_sets: {exercise_weight: :exercise} ).find(params[:id])
    end

    def setup_model!(params)
      model.workout_date = Time.now
      quick_adder = WorkoutSetQuickAdder.new(params['new_workout_set'])
      quick_adder.add_sets_to_workout(model)
    end
  end
end
