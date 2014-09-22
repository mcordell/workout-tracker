# == Schema Information
#
# Table name: subcycles
#
#  id         :integer          not null, primary key
#  cycle_id   :integer
#  number     :integer
#  created_at :datetime
#  updated_at :datetime
#

class Subcycle < ActiveRecord::Base
  belongs_to :cycle
  has_many :workouts

  def copy_from_object(subcycle)
    subcycle.workouts.each do |work|
      workout = workouts.build
      workout.copy_from_object(work)
    end
  end

  def finished?
    workouts.each do |workout|
      return false unless workout.workout_date
    end
    true
  end
end
