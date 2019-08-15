class Schedule
  attr_accessor :booked, :events

  def initialize
    @events = []
    @booked = []
  end

  def overlaps?(time1, time2)
    time1.overlaps?(time2)
  end

  def weekly_schedule
    days = (0...7).to_a.map { [] }

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
end
