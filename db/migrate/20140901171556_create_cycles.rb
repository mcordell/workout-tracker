class CreateCycles < ActiveRecord::Migration
  def change
    create_table :cycles do |t|
      t.references :starting_weight
      t.references :program
      t.integer :cycle_number

      t.timestamps
    end
  end
end
