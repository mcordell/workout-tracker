# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)      default(""), not null
#  encrypted_password     :string(255)      default(""), not null
#  reset_password_token   :string(255)
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  date_of_birth          :datetime
#  first_name             :string(255)
#  last_name              :string(255)
#  created_at             :datetime
#  updated_at             :datetime
#

# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    first_name "John"
    last_name "Wayne"
    sequence (:email) { |n| "someperson#{n}@example.com" }
    password "password"
  end

  trait :with_inactive_programs do
    after(:create) do |user|
      FactoryGirl.create_list(:program, 2, :inactive, user: user)
    end
  end

  trait :with_active_program do
    after(:create) do |user|
      FactoryGirl.create_list(:program, 2, :inactive, user: user)
    end
  end
end
