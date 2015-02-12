# == Schema Information
#
# Table name: cycles
#
#  id                 :integer          not null, primary key
#  starting_weight_id :integer
#  program_id         :integer
#  cycle_number       :integer
#  created_at         :datetime
#  updated_at         :datetime
#  active             :boolean
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cycle do
    association :starting_weight, factory: :body_weight
    program
    cycle_number 1
  end

  trait :inactive do
    active false
  end

  trait :with_unfinished_subcycle do
    after(:create) do |cycle|
      FactoryGirl.create(:subcycle, :with_not_completed_workouts, cycle: cycle)
    end
  end

  trait :with_finished_subcycles do
    after(:create) do |cycle|
      FactoryGirl.create_list(:subcycle, 2, :with_completed_workouts, cycle: cycle)
    end
  end

  trait :in_active_program do
    before(:create) do |cycle|
      cycle.program = FactoryGirl.create(:program, active: true)
    end
  end
end
