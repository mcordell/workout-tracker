# == Schema Information
#
# Table name: workouts
#
#  id           :integer          not null, primary key
#  subcycle_id  :integer
#  workout_date :datetime
#  notes        :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Workout < ActiveRecord::Base
  belongs_to :subcycle
  has_many :workout_sets
  scope :incomplete, -> { where('workout_date is NULL') }
  accepts_nested_attributes_for :workout_sets
  delegate :cycle, to: :subcycle
  delegate :program, to: :cycle

  def copy_from_object(workout)
    workout.sets.each do |set_obj|
      set = workout_sets.build
      set.copy_from_object(set_obj)
    end
  end
end
