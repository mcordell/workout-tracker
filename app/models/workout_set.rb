# == Schema Information
#
# Table name: workout_sets
#
#  id            :integer          not null, primary key
#  exercise_id   :integer
#  workout_id    :integer
#  intended_reps :integer
#  weight        :integer
#  peformed_reps :integer
#  created_at    :datetime
#  updated_at    :datetime
#  options       :text
#  weight_id     :integer
#

class WorkoutSet < ActiveRecord::Base

  before_destroy :destroy_weight

  belongs_to :exercise
  belongs_to :workout
  belongs_to :weight
  serialize :options, Array
  delegate  :cycle, to: :workout
  delegate :program, to: :workout

  def copy_from_object(set_obj)
    exercise = Exercise.find_or_create_by(name: set_obj.exercise)
    self.weight = Weight.new(value: set_obj.weight, weightable: exercise)
    assign_reps(set_obj.reps)
  end

  def assign_reps(reps)
    if /\d+\+/.match(reps.to_s)
      self.options.push(:plus_set)
      self.intended_reps = reps.gsub(/\+/,'')
    else
      self.intended_reps = reps
    end
  end

  def is_plus_set?
    options.include? :plus_set
  end

  def rep_difference
    self.peformed_reps ? self.peformed_reps - self.intended_reps : 0
  end

  def exercise_name
    weight ? weight.exercise_name : ""
  end

  def destroy_weight
    self.weight.delete if self.weight
  end
end
