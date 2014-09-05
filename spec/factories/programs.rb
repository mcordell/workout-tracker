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
    name "MyString"
    user ""
  end
end
