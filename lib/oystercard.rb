require 'money'
require 'pry'

class Oystercard
   DEFAULT_MAX_BALANCE = 90
   MINIMUM_FARE = 1
  attr_accessor :balance, :max_balance, :money
  attr_reader :entry_station

  def initialize(balance = 0, max_balance = DEFAULT_MAX_BALANCE)
    @balance = balance
    @max_balance = max_balance
    @entry_station = nil
    # @money = money
  end

  def top_up(money)
    raise 'Max top up allowed is £90. Please select different amount' if max(money) #money + balance > DEFAULT_MAX_BALANCE
    @balance += money
  end

  def touch_in(entry_station)
    raise 'Insufficient funds - please top up' if @balance < MINIMUM_FARE # balance also works here
    @entry_station = entry_station
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end

  private

  def max(money)
    money + @balance > DEFAULT_MAX_BALANCE #also works with balance
  end
end

def deduct(fare)
  @balance -= fare
end

binding.pry
