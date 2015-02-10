# == Schema Information
#
# Table name: exercises
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'rails_helper'

describe Exercise do
  let(:exercise) { FactoryGirl.create(:exercise) }

  context "when name is not present" do
    before { exercise.name = nil }

    it "is not valid" do
      expect(exercise).not_to be_valid
    end
  end
end
