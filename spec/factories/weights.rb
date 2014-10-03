# == Schema Information
#
# Table name: weights
#
#  id         :integer          not null, primary key
#  value      :integer
#  user_id    :integer
#  unit       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :weight do
    value 186
    unit "lb"
  end
end
