class CreateWorkoutSets < ActiveRecord::Migration
  def change
    create_table :workout_sets do |t|
      t.references :exercise, index: true
      t.references :workout
      t.integer :intended_reps
      t.integer :weight
      t.integer :peformed_reps

      t.timestamps
    end
  end
end
