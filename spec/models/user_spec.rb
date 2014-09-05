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
#  sign_in_count          :integer          default(0), not null
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

require 'spec_helper'

RSpec.describe User, :type => :model do
  let(:user) { FactoryGirl.create(:user, email: "one@example.com", password: "password") }
  describe "#name" do
    it "returns the first and last name concatenated" do
      expect(user.name).to eq "#{user.first_name} #{user.last_name}"
    end
  end
end
