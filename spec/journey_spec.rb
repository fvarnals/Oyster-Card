require 'journey'

describe Journey do

  #let(:station) { double(station) } why does this create stack error?
 it "receive a entry station on initialize" do
   test_station = double (:station)
   # allow(test_station).to receive(:name) { "aldgate east" }
   test_journey = Journey.new(test_station)
   expect(test_journey.entry_station).not_to eq nil
 end

 it "when oystercard taps out it should accept an exit station" do
   test_station = double (:station)
   test_journey = Journey.new(test_station)
   test_journey.end_journey(test_station)
   expect(test_journey.exit_station).not_to eq nil
 end
 it "should have a fare once journey complete" do
   test_station = double (:station)
   test_journey = Journey.new(test_station)
   test_journey.end_journey(test_station)
   expect(test_journey.fare).to eq 1
 end
 it "should set entry station to nil when tapping out without a tap in and fare to £6" do
   test_station = double (:station)
   test_journey = Journey.new
   test_journey.end_journey(test_station)
   expect(test_journey.fare).to eq 6
 end
 it "should have a penalty fare if forgot to tap out" do
   test_station = double (:station)
   test_journey = Journey.new(test_station)
   test_journey.end_journey
   expect(test_journey.fare).to eq 6
 end
end
