require 'weather'

describe Weather do
  it 'Says the is good' do
    allow(subject).to receive(:rand).and_return 2
    expect(subject.good_weather?).to eq true
  end

  it 'Says the weather is bad' do
    allow(subject).to receive(:rand).and_return 3
    expect(subject.good_weather?).to eq false
  end
end
