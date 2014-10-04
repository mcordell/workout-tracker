class CycleWeight < ActiveRecord::Base
  belongs_to :weight
  belongs_to :cycle
  accepts_nested_attributes_for :weight
end
