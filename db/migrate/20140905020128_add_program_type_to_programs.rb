class AddProgramTypeToPrograms < ActiveRecord::Migration
  def change
    add_column :programs, :program_type, :string
  end
end
