require 'rails_helper'

describe Program do
  let(:program) { FactoryGirl.create(:program) }

  context "when name is not present" do
    before { program.name = nil }

    it "is not valid" do
      expect(program).not_to be_valid
    end
  end
end
