class CycleWeight < ActiveRecord::Base

  before_destroy :destroy_weight

  belongs_to :weight
  belongs_to :cycle
  accepts_nested_attributes_for :weight

  def destroy_weight
    self.weight.delete if self.weight
  end
end
