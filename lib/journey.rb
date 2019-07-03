class Journey

  attr_reader :entry_station, :exit_station, :fare
  def initialize(station = nil)
    @entry_station = station
    @exit_station = nil
    @fare = nil
  end

  def end_journey(station = nil)
    @exit_station = station
    fare_calculate
  end

  def fare_calculate
    if @entry_station.nil? || @exit_station.nil?
      @fare = 6
    else
      @fare = Oystercard::MINIMUM_FARE
    end
  end

end
