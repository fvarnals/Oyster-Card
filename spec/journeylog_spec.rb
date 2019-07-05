require 'journeylog'
require 'pry'

describe JourneyLog do
  subject { described_class.new(journey_class) }
  let(:journey) { double :journey }
  let(:journey_class) { double(:journey_class, new: journey) }
  let(:station) { double :station }

  # it "when initialized it has a journey class" do
  #   expect(subject).to respond_to(:new).with(:journey_class)
  # end

  describe '#start' do
    it "should start a new journey with an entry station" do
      expect(subject.start(station)).to be_instance_of(Journey)
    end
  end

  describe '#finish' do
    it "should add an exit station to the current journey" do
      subject.start(station)
      expect(subject.finish(station).exit_station).to eq station
    end
  end

  describe '#journeys' do
    it "returns a list of all previous journeys" do
      subject.start(station)
      subject.finish(station)
      expect(subject.journeys.length).to eq 1
    end
  end
end

binding.pry
