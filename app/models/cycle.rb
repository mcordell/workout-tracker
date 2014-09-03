class Cycle < ActiveRecord::Base
  belongs_to :program
  belongs_to :starting_weight, class_name: 'Weight'
  has_many :subcycles
  scope :active, -> { where(active: true) }
end
