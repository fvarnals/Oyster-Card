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

  end
  end
