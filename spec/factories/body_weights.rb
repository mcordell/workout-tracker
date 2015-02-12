# == Schema Information
#
# Table name: body_weights
#
#  id         :integer          not null, primary key
#  value      :integer
#  user_id    :integer
#  unit       :string
#  created_at :datetime
#  updated_at :datetime
#

FactoryGirl.define do
  factory :body_weight do
    value 186
    unit "lb"
  end
end
