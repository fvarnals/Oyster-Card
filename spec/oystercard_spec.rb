require 'oystercard'
require 'faker'

describe Oystercard do
  subject(:oystercard) { described_class.new }
  let(:money) { Faker::Number.between(1, 10) }
  describe '#new' do
    it "has no balance when inititialized" do
      expect(oystercard.balance).to eq 0
    end
  end
  describe '#top_up' do
    it 'we want a top-up method which allows adding money to balance' do
      expect(oystercard.top_up(money)).to eq (0 + money)
    end
  end
end
