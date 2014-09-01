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
