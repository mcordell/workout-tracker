# == Schema Information
#
# Table name: cycle_weights
#
#  id         :integer          not null, primary key
#  weight_id  :integer
#  cycle_id   :integer
#  flag       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class CycleWeight < ActiveRecord::Base
  belongs_to :exercise_weight
  belongs_to :cycle
  accepts_nested_attributes_for :exercise_weight
end
