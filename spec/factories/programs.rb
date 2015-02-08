# == Schema Information
#
# Table name: programs
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  user_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#  active       :boolean
#  program_type :string(255)
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :program do
    name "Five three one"
    user
  end

  trait :with_inactive_cycles do
    after(:create) do |program|
      FactoryGirl.create_list(:cycle, 3, :inactive, program: program)
    end
  end

  trait :with_active_cycle do
    after(:create) do |program|
      FactoryGirl.create(:cycle, program: program)
    end
  end

  trait :with_unfinished_cycle do
    after(:create) do |program|
      FactoryGirl.create(:cycle, :with_unfinished_subcycle, program: program)
    end
  end

  trait :with_finished_cycles do
    after(:create) do |program|
      FactoryGirl.create(:cycle, :with_finished_subcycles, program: program)
    end
  end
end
