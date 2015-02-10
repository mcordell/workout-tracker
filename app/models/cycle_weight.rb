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

  before_destroy :destroy_weight

  belongs_to :weight
  belongs_to :cycle
  accepts_nested_attributes_for :weight

  def destroy_weight
    self.weight.delete if self.weight
  end
end
