class CreatePrograms < ActiveRecord::Migration
  def change
    create_table :programs do |t|
      t.string :name
      t.belongs_to :user

      t.timestamps
    end
  end
end
