class RenameWeightToExerciseWeight < ActiveRecord::Migration
  def change
    rename_table :weights, :exercise_weights
    rename_column :cycle_weights, :weight_id, :exercise_weight_id
    rename_column :workout_sets, :weight_id, :exercise_weight_id
  end
end
