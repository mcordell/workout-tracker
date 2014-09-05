class AddOptionsToWorkoutSets < ActiveRecord::Migration
  def change
    add_column :workout_sets, :options, :text
  end
end
