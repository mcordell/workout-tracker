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

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workout_set do
    exercise nil
    workout
    intended_reps 1
    performed_reps 1
    exercise_weight
  end
end
