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

  describe ".display_name" do
    before { exercise.name = 'overhead_press' }

    it "returns a humanized version of the name" do
      expect(exercise.display_name).to eq 'Overhead press'
    end
  end

  describe ".display_name=" do
    it "sets a snake case version of the display name" do
      exercise.name = nil
      exercise.display_name = 'Overhead press'
      expect(exercise.name).to eq 'overhead_press'
    end
  end
end
