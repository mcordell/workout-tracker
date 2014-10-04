class CreateCycleWeights < ActiveRecord::Migration
  def change
    create_table :cycle_weights do |t|
      t.belongs_to :weight
      t.belongs_to :cycle
      t.string     :flag
      t.timestamps
    end
  end
end
