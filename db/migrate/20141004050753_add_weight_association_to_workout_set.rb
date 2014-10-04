class AddWeightAssociationToWorkoutSet < ActiveRecord::Migration
  def change
    add_belongs_to :workout_sets, :weight
  end
end
