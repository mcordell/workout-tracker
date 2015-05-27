# == Schema Information
#
# Table name: weights
#
#  id              :integer          not null, primary key
#  value           :integer
#  user_id         :integer
#  unit            :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  weightable_id   :integer
#  weightable_type :string(255)
#
require 'rails_helper'

describe ExerciseWeight do

  let(:exercise_weight) { FactoryGirl.build(:exercise_weight, exercise_name: 'Something') }
  subject { exercise_weight }

  it_behaves_like 'weight'

  it "delegates name to its exercise" do
    exercise_weight = FactoryGirl.create(:exercise_weight, exercise_name: 'Something')
    expect(exercise_weight.name).to eq 'Something'
  end

  context 'when the exercise is not present' do
    before { exercise_weight.exercise = nil }

    it "is not valid" do
      expect(exercise_weight).not_to be_valid
    end
  end
end
