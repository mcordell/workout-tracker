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
#

class WorkoutSet < ActiveRecord::Base
  belongs_to :exercise
  belongs_to :workout
end
