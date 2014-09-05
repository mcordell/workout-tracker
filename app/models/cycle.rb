class Cycle < ActiveRecord::Base
  belongs_to :program
  belongs_to :starting_weight, class: Weight, :foreign_key => "starting_weight_id"
  has_many :subcycles
  scope :active, -> { where(active: true) }
end
