# == Schema Information
#
# Table name: subcycles
#
#  id         :integer          not null, primary key
#  cycle_id   :integer
#  number     :integer
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :subcycle do
    cycle
    number 1
  end

  trait :with_not_completed_workouts do
    after(:create) do |subcycle|
      FactoryGirl.create_list(:workout, 2, :not_completed, subcycle: subcycle)
    end
  end

  trait :with_completed_workouts do
    after(:create) do |subcycle|
      FactoryGirl.create_list(:workout, 2, :completed, subcycle: subcycle)
    end
  end

  trait :in_active_cycle do
    before(:create) do |subcycle|
      subcycle.cycle = FactoryGirl.create(:cycle, :in_active_program, active: true)
    end
  end
end
