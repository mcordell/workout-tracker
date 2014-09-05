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

require 'rails_helper'

RSpec.describe WorkoutSet, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
