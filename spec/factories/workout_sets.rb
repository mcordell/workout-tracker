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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workout_set do
    exercise nil
    workout ""
    intended_reps 1
    weight 1
    peformed_reps 1
  end
end
