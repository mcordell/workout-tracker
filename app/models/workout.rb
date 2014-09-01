class Workout < ActiveRecord::Base
  belongs_to :subcycle
  has_many :workout_sets
end
