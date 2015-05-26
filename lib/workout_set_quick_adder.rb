class WorkoutSetQuickAdder
  def initialize(quick_add_params)
    @params = quick_add_params
  end

  def add_sets_to_workout(workout)
    @params.to_a.each do |id, row|
      if /\d+/.match(id)
        exercise_weight = ExerciseWeight.find_or_initialize_by(exercise_id: row['exercise_id'], value: row['weight'])
        workout.workout_sets.build(exercise_weight: exercise_weight, performed_reps: row['performed_reps'])
      end
    end
  end
end
