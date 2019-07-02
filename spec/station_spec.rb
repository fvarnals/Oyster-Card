require 'station'

describe Station do
  it 'tells the user which zone it is in' do
    denmark_hill = Station.new("Denmark Hill", 2)
    expect(denmark_hill.zone).to eq 2
  end
end
