# == Schema Information
#
# Table name: weights
#
#  id              :integer          not null, primary key
#  value           :integer
#  user_id         :integer
#  unit            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  weightable_id   :integer
#  weightable_type :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :exercise_weight do
    transient do
      exercise_name 'Pull up'
    end

    value 186
    unit "lb"
    exercise

    after(:create) do |exercise_weight, evaluator|
      exercise_weight.exercise.update_attribute(:name, evaluator.exercise_name)
    end
  end
end
