class Schedule
  attr_accessor :booked, :events
  attr_reader :not_booked

  def initialize
    @events = []
    @booked = []
  end

  def overlaps?(time1, time2)
    time1.overlaps?(time2)
  end

  def weekly_schedule
    days = (0...6).to_a.map { [] }

    booked.each do |event|
      # TODO: push time on to schedule
      days[event.wday] << 'hh:ss'
    end

    days
  end

  def not_booked
    events.reject { |e| e.wday == 4 }
  end
end
