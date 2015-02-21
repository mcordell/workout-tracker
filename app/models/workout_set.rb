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
  belongs_to :exercise_weight
  serialize :options, Array

  delegate  :cycle, to: :workout
  delegate :program, to: :workout
  delegate :subcycle, to: :workout
  delegate :name, to: :exercise_weight, allow_nil: true

  validates :exercise_weight, presence: true

  def copy_from_object(set_obj)
    exercise = Exercise.find_or_create_by(name: set_obj.exercise)
    self.exercise_weight = ExerciseWeight.new(value: set_obj.weight,
                                              weightable: exercise)
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

  def from_hash(hash)
    weight_value = hash.delete(:weight)
    exercise_name = hash.delete(:exercise)
    if exercise_name
      self.exercise = Exercise.find_or_create_by(name: exercise_name)
      exercise_weight_attributes = { value: weight_value.to_i,
                                     exercise: exercise }
      build_exercise_weight(exercise_weight_attributes)
    end
    assign_reps(hash.delete(:reps))
    update(hash)
  end

  def plus_set?
    options.include? :plus_set
  end

  def rep_difference
    performed_reps - intended_reps if performed_reps
  end
end
