RSpec.shared_examples "weight" do
  before { subject.value = 70 }

  it "defaults to 'lbs' when a unit is not provided at creation" do
    subject.unit = nil
    subject.save
    expect(subject.unit).to eq 'lbs'
  end

  it "is not valid without a value" do
    subject.value = nil
    expect(subject).not_to be_valid
  end
end
