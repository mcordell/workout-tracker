class CreateSubcycles < ActiveRecord::Migration
  def change
    create_table :subcycles do |t|
      t.belongs_to :cycle
      t.integer :number

      t.timestamps
    end
  end
end
