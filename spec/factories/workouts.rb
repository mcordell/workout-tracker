# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workout do
    subcycle nil
    workout_date "2014-09-01 10:31:29"
    notes "MyText"
  end
end
