require 'rails_helper'

describe Weight do
  it "defaults to 'lbs' when a unit is not provided at creation" do
    weight = FactoryGirl.create(:weight, unit: nil)
    expect(weight.unit).to eq 'lbs'
  end

  it "delegates name to its weightable" do
    exercise = FactoryGirl.create(:exercise, name: 'Something')
    weight = FactoryGirl.create(:weight, weightable: exercise)
    expect(weight.name).to eq 'Something'
  end
end
