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
    transient do
      weight 200
    end

    workout
    intended_reps 1
    performed_reps 1
    exercise_weight

    factory :press_workout_set do
      exercise_weight FactoryGirl.create(:exercise_weight, exercise_name: 'Press')
    end

    after(:create) do |workout_set, evaluator|
      exercise_weight = workout_set.exercise_weight
      exercise_weight.update_attribute(:value, evaluator.weight)
    end
  end
end
