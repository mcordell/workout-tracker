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
end
