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
  has_many :workout_sets, dependent: :destroy
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

  def from_hash(hash)
    sets = hash.delete(:workout_sets).to_a + hash.delete(:sets).to_a

    sets.each do |set_hash|
      workout_sets.build.from_hash(set_hash)
    end
    update(hash)
  end
end
