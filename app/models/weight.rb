# == Schema Information
#
# Table name: weights
#
#  id              :integer          not null, primary key
#  value           :integer
#  user_id         :integer
#  unit            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  weightable_id   :integer
#  weightable_type :string(255)
#

class Weight < ActiveRecord::Base
  belongs_to :weightable, polymorphic: true

  before_save :defaults

  def defaults
    unit = 'lb' if unit.nil?
  end

  def exercise_name
    weightable.name if weightable.class == Exercise
  end
end
