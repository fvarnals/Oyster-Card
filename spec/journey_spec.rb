require 'journey'
require 'oystercard'

describe Journey do
  describe 'touch_in' do
    it 'is in journey if card is touched in' do
      subject.top_up(10)
      subject.touch_in(:station)
      expect(subject.in_journey?).to eq true
    end
    it 'raises error if balance is below touch in minimum' do
      expect { subject.touch_in(:station) }.to raise_error 'Insufficient funds - please top up'
    end
    it 'records entry station after the touch in' do
      subject.top_up(10)
      subject.touch_in(:station)
      expect(subject.entry_station).to eq :station
    end
  end

  describe 'touch_out' do
    it 'is not in journey if card is touched out' do
      subject.top_up(10)
      subject.touch_in(:station)
      subject.touch_out(:station)
      expect(subject.in_journey?).to eq false
    end
    it 'charges minimum fare when touch out' do
      subject.top_up(10)
      subject.touch_in(:station)
      expect { subject.touch_out(:station) }.to change{subject.balance}.by(Oystercard::MINIMUM_FARE)
    end
    it 'records a journey when touching in and out' do
      subject.top_up(10)
      subject.touch_in(:station)
      subject.touch_out(:station)
      expect(subject.journey_history.length).to eq 1
    end
  end
end
