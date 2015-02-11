# == Schema Information
#
# Table name: workout_sets
#
#  id             :integer          not null, primary key
#  exercise_id    :integer
#  workout_id     :integer
#  intended_reps  :integer
#  weight         :integer
#  performed_reps :integer
#  created_at     :datetime
#  updated_at     :datetime
#  options        :text
#  weight_id      :integer
#

class WorkoutSet < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :workout
  belongs_to :weight
  serialize :options, Array

  delegate  :cycle, to: :workout
  delegate :program, to: :workout
  delegate :subcycle, to: :workout
  delegate :name, to: :weight, allow_nil: true

  def copy_from_object(set_obj)
    exercise = Exercise.find_or_create_by(name: set_obj.exercise)
    self.weight = Weight.new(value: set_obj.weight, weightable: exercise)
    assign_reps(set_obj.reps)
  end

  def assign_reps(reps)
    reps = reps.to_s
    fail if /-\d+/.match(reps)
    if /\d+\+/.match(reps)
      options.push(:plus_set)
      self.intended_reps = reps.gsub(/\+/, '')
    else
      self.intended_reps = reps
    end
  end

  def plus_set?
    options.include? :plus_set
  end

  def rep_difference
    performed_reps - intended_reps if performed_reps
  end
end
