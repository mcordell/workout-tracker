require 'spec_helper'

RSpec.describe User, :type => :model do
  let(:user) { FactoryGirl.create(:user, email: "one@example.com", password: "password") }
  describe "#name" do
    it "returns the first and last name concatenated" do
      expect(user.name).to eq "#{user.first_name} #{user.last_name}"
    end
  end
end
