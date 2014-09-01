class CreateWorkouts < ActiveRecord::Migration
  def change
    create_table :workouts do |t|
      t.references :subcycle, index: true
      t.datetime :workout_date
      t.text :notes

      t.timestamps
    end
  end
end
