require 'oystercard'
require 'faker'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:money) { Faker::Number.between(1, 10) }
  let(:station) { double(station) }
  describe '#new' do
    it "has no balance when inititialized" do
      expect(oystercard.balance).to eq 0
    end
    it 'has a set max of £90' do
    expect(oystercard.max_balance).to eq Oystercard::DEFAULT_MAX_BALANCE
    end
    it 'raises an error if someone tries to put more than £90' do
      oystercard.top_up(Oystercard::DEFAULT_MAX_BALANCE)
      expect { oystercard.top_up(money) }.to raise_error 'Max top up allowed is £90. Please select different amount'
    end

  end
  describe '#top_up' do
    it 'we want a top-up method which allows adding money to balance' do
      expect(oystercard.top_up(money)).to eq (0 + money)
    end

    describe 'touch_in' do
      it 'is in journey if card is touched in' do
        oystercard.top_up(10)
        oystercard.touch_in(:station)
        expect(oystercard.in_journey?).to eq true
      end
      it 'raises error if balance is below touch in minimum' do
        expect { oystercard.touch_in(:station) }.to raise_error 'Insufficient funds - please top up'
      end
      it 'records entry station after the touch in' do
        oystercard.top_up(10)
        oystercard.touch_in(:station)
        expect(oystercard.entry_station).to eq :station
      end
    end

    describe 'touch_out' do
      it 'is not in journey if card is touched out' do
        oystercard.top_up(10)
        oystercard.touch_in(:station)
        oystercard.touch_out
        expect(oystercard.in_journey?).to eq false
      end
      it 'charges minimum fare when touch out' do
        oystercard.top_up(10)
        oystercard.touch_in(:station)
        expect { oystercard.touch_out }.to change{oystercard.balance}.by(-Oystercard::MINIMUM_FARE)
      end
    end

  end
  end
