require 'rails_helper'

describe Cycle do
  let(:cycle) { FactoryGirl.create(:cycle) }


  it "is active on initialization" do
    cycle = Cycle.new
    cycle.save
    expect(cycle.active?).to be_truthy
  end
end
