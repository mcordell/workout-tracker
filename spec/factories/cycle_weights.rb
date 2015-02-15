# == Schema Information
#
# Table name: cycle_weights
#
#  id         :integer          not null, primary key
#  weight_id  :integer
#  cycle_id   :integer
#  flag       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cycle_weight do
    cycle
    exercise_weight
  end

  trait :with_exercise_name_and_value do
    transient do
      name 'Pull up'
      value 20
    end

    after(:create) do |cycle_weight, evaluator|
      exercise_weight = cycle_weight.exercise_weight
      exercise_weight.exercise.update_attribute(:name, evaluator.name)
      exercise_weight.update_attribute(:value, evaluator.value)
    end
  end
end
