class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.integer :value
      t.belongs_to :user
      t.string :unit

      t.timestamps
    end
  end
end
