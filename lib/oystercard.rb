require 'money'
require 'pry'

class Oystercard
   DEFAULT_MAX_BALANCE = 90
   MINIMUM_FARE = 1
  attr_accessor :balance, :max_balance, :money

  def initialize(balance = 0, max_balance = DEFAULT_MAX_BALANCE)
    @balance = balance
    @max_balance = max_balance
    @in_journey = false
    # @money = money
  end

  def top_up(money)
    raise 'Max top up allowed is £90. Please select different amount' if max(money) #money + balance > DEFAULT_MAX_BALANCE
    @balance += money
  end

  def touch_in
    raise 'Insufficient funds - please top up' if @balance < MINIMUM_FARE # balance also works here
    @in_journey = true
  end

  def touch_out
    deduct(MINIMUM_FARE)
    @in_journey = false
  end

  def in_journey?
    @in_journey
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
