require 'pry'

class Oystercard
   DEFAULT_MAX_BALANCE = 90
   MINIMUM_FARE = 1
  attr_accessor :balance, :max_balance, :amount
  attr_reader :entry_station, :journey_history

  def initialize(balance = 0, max_balance = DEFAULT_MAX_BALANCE)
    @balance = balance
    @max_balance = max_balance
    @journey_history = JourneyLog.new
    @current_journey = nil
    # @amount = amount
  end

  def top_up(amount)
    raise 'Max top up allowed is £90. Please select different amount' if above_max(amount) #amount + balance > DEFAULT_MAX_BALANCE
    @balance += amount
  end

  def touch_in(station)
    check_sufficient_funds
    @current_journey.nil? ? @journey_history.start(station) : resolve_unended_journey_and_start_new_journey(station)
  end

  def touch_out(station)
    @journey_history.start(station) if @current_journey.nil?
    @journey_history.finish(station)
  end

  def in_journey?
    @entry_station != nil
  end

  def check_sufficient_funds
    raise 'Insufficient funds - please top up' if @balance < MINIMUM_FARE # balance also works here
  end

  private

  def finish_journey(station = nil)
    @current_journey.end_journey(station)
    store_journey_and_deduct_fare
  end

  def store_journey_and_deduct_fare
    @journey_history << @current_journey
    deduct(@current_journey.fare)
    @current_journey = nil
  end

  def above_max(amount)
    amount + @balance > DEFAULT_MAX_BALANCE #also works with balance
  end
end

def deduct(fare)
  @balance -= fare
end

def resolve_unended_journey_and_start_new_journey(station)
  finish_journey
  start_journey(station)
end

#binding.pry
