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
