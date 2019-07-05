require 'journey'

class JourneyLog

  def initialize(journey_class = Journey)
    @journey_class = journey_class
    @journey_list = []
    @active_journey = nil
  end

  def start(station)
    @active_journey = Journey.new(station)
    return @active_journey
  end

  def finish(station)
    current_journey.end_journey(station)
    @journey_list << current_journey
    @journey_list.last
  end

  def journeys
    @journey_list
  end

  private

  def current_journey
    latest_journey = @active_journey
    if latest_journey == nil
      @journey_class.new
    end
    return latest_journey
  end


end
