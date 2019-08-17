class Schedule
  attr_accessor :booked, :events

  def initialize
    @events = []
    @booked = []
  end

  def overlaps_time?(event_one, event_two)
    overlaps?(event_one.time_to_range, event_two.time_to_range)
  end

  def weekly_schedule
    week = { sun: [], mon: [], tue: [], wed: [], thu: [], fri: [], sat: [] }

    booked.each do |event|
      week[event.week_day.downcase.to_sym] << event.time_to_range
    end

    week
  end

  def clashes?(event_one, event_two)
    event_one.week_day == event_two.week_day && overlaps_time?(event_one, event_two)
  end

  def not_booked
    events.reject do |available_event|
      clashes = booked.select do |booked_event|
        overlaps_time?(available_event, booked_event)
      end

      clashes.length.positive?
    end
  end

  private

  def overlaps?(time_one, time_two)
    time_one.overlaps?(time_two)
  end
end
