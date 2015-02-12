RSpec.shared_examples "weight" do
  let(:weight) { described_class.new(value: 70) }

  it "defaults to 'lbs' when a unit is not provided at creation" do
    weight.unit = nil
    weight.save
    expect(weight.unit).to eq 'lbs'
  end


  it "is not valid without a value" do
    weight.value = nil
    expect(weight).not_to be_valid
  end
end
