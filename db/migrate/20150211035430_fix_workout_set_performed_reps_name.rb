class FixWorkoutSetPerformedRepsName < ActiveRecord::Migration
  def change
    rename_column :workout_sets, :peformed_reps, :performed_reps
  end
end
