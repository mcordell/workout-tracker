class AddWeightTypes < ActiveRecord::Migration
  def change
    add_reference(:weights, :weightable, polymorphic: true)
  end
end
