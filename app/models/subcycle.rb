class Subcycle < ActiveRecord::Base
  belongs_to :cycle
  has_many :workouts
end
