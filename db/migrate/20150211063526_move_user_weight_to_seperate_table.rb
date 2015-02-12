class MoveUserWeightToSeperateTable < ActiveRecord::Migration
  class Weight < ActiveRecord::Base
  end

  class BodyWeight < ActiveRecord::Base
  end

  class User < ActiveRecord::Base
  end

  class Cycle < ActiveRecord::Base
  end

  def up
    create_table :body_weights do |t|
      t.integer :value
      t.belongs_to :user
      t.string :unit
      t.timestamps
    end

    Weight.where('weightable_type = ?', 'User').each do |weight|
      bw = BodyWeight.create(
        user_id: weight.weightable_id,
        value: weight.value,
        unit: weight.unit
      )
      Cycle.where(starting_weight_id: weight.id).each do |cycle|
        cycle.update_attribute(:starting_weight_id, bw.id)
      end
      weight.delete
    end
  end

  def down
    BodyWeight.all.each do |body_weight|
      weight = Weight.create(
        weightable_id: body_weight.user_id,
        weightable_type: 'User',
        value: body_weight.value,
        unit: body_weight.unit)
      Cycle.where(starting_weight_id: body_weight.id).each do |cycle|
        cycle.update_attribute(:starting_weight_id, weight.id)
      end
    end

    drop_table :body_weights
  end
end
