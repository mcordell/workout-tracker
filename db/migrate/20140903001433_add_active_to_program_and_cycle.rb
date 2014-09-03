class AddActiveToProgramAndCycle < ActiveRecord::Migration
  def change
    add_column :programs, :active, :boolean
    add_column :cycles, :active, :boolean
  end
end
