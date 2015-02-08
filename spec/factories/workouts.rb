# == Schema Information
#
# Table name: workouts
#
#  id           :integer          not null, primary key
#  subcycle_id  :integer
#  workout_date :datetime
#  notes        :text
#  created_at   :datetime
#  updated_at   :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :workout do
    subcycle
    notes "MyText"
  end

  trait :not_completed do
    workout_date nil
  end

  trait :completed do
    workout_date "2014-09-01 10:31:29"
  end
end
