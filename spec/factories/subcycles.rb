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
    cycle ""
    number 1
  end
end
