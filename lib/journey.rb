require 'oystercard'

class Journey

  def initialize
    @entry_station = nil
    @journey_history = []
    # @money = money
  end

  def touch_in(entry_station, oystercard)
    raise 'Insufficient funds - please top up' if @balance < Oystercard::MINIMUM_FARE # balance also works here
    @entry_station = entry_station
  end

  def touch_out(exit_station, oystercard)
    oystercard.deduct(Oystercard::MINIMUM_FARE)
    @journey_history << {entry_station: entry_station, exit_station: exit_station}
    @entry_station = nil
  end

  def in_journey?
    @entry_station != nil
  end


end
