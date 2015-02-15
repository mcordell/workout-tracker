class RenameWeightableToExerciseOnExerciseWeights < ActiveRecord::Migration
  def change
    rename_column :exercise_weights, :weightable_id, :exercise_id
    remove_column :exercise_weights, :weightable_type
  end
end
