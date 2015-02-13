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

require 'rails_helper'

describe User do

  let(:user) { FactoryGirl.create(:user, first_name: 'Jon', last_name: 'Smith') }

  describe ".name" do
    it "returns the concatenated first and last name" do
      user = FactoryGirl.create(:user, first_name: 'Jon', last_name: 'Smith')
      expect(user.name).to eq 'Jon Smith'
    end
  end

  describe ".current_program" do
    context "when user does not have any programs" do
      it "returns nil" do
        expect(user.current_program).to be_nil
      end
    end

    context "when user does not have any active programs" do
      let(:user_with_inactive_programs) { FactoryGirl.create(:user, :with_inactive_programs) }

      it "returns nil" do
        expect(user_with_inactive_programs.current_program).to be_nil
      end
    end

    context "when user has one active program" do
      let(:user_with_active_program) { FactoryGirl.create(:user) }
      let!(:program) { FactoryGirl.create(:program, active: true, user: user_with_active_program) }

      it "returns the program" do
        expect(user_with_active_program.current_program).to eq program
      end
    end

    context "when the user has multiple active programs" do
      let(:user_with_active_program) { FactoryGirl.create(:user) }
      let!(:first_program) { FactoryGirl.create(:program, active: true, user: user_with_active_program) }
      let!(:second_program) { FactoryGirl.create(:program, active: true, user: user_with_active_program) }

      it "returns the most recently created program" do
        expect(user_with_active_program.current_program).to eq second_program
      end
    end
  end

  describe ".next_workout" do
    let(:user) { FactoryGirl.create(:user) }
    let(:workout) { FactoryGirl.create(:workout, :in_active_subcycle) }

    before do
      workout.subcycle.cycle.program.update_attribute(:user, user)
    end

    it "returns the next_workout for the current_program" do
      expect(user.next_workout).to eq workout
    end
  end
end
