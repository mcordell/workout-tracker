class DropWeightColumnFromWorkoutSet < ActiveRecord::Migration
  def change
    remove_column :workout_sets, :weight
  end
end
