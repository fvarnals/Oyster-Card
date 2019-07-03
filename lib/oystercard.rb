require 'money'
require 'pry'

class Oystercard
   DEFAULT_MAX_BALANCE = 90
   MINIMUM_FARE = 1
  attr_accessor :balance, :max_balance, :money
  attr_reader :entry_station, :journey_history

  def initialize(balance = 0, max_balance = DEFAULT_MAX_BALANCE)
    @balance = balance
    @max_balance = max_balance
    @entry_station = nil
    @journey_history = []
    @current_journey = nil
    # @money = money
  end

  def top_up(money)
    raise 'Max top up allowed is £90. Please select different amount' if max(money) #money + balance > DEFAULT_MAX_BALANCE
    @balance += money
  end

  def touch_in(entry_station)
    raise 'Insufficient funds - please top up' if @balance < MINIMUM_FARE # balance also works here
    if @current_journey.nil?
      @current_journey = Journey.new(entry_station)
    else
      @current_journey.end_journey
      @journey_history << @current_journey
      deduct(@current_journey.fare)
      @current_journey = nil
      @current_journey = Journey.new(entry_station)
    end
  end

  def touch_out(exit_station)
    if @current_journey.nil?
      @current_journey = Journey.new
    end
    @current_journey.end_journey(exit_station)
    @journey_history << @current_journey
    deduct(@current_journey.fare)
    @current_journey = nil
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
