class Schedule
  attr_accessor :booked, :events

  def initialize
    @events = []
    @booked = []
  end

  def overlaps_time?(event_1, event_2)
    overlaps?(event_1.time_to_range, event_2.time_to_range)
  end

  def weekly_schedule
    days = (0..6).to_a.map { [] }

    booked.each do |event|
      # TODO: push time on to schedule
      days[event.wday] << 'hh:ss'
    end

    days
  end

  def not_booked
    days_booked = weekly_schedule.map.with_index { |day, i| i unless day.empty? }.compact
    events.reject { |e| days_booked.include?(e.wday) }
  end

  private

  def overlaps?(time_1, time_2)
    time_1.overlaps?(time_2)
  end
end
