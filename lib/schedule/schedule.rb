class Schedule
  attr_accessor :booked, :events
  attr_reader :not_booked

  def overlaps?(time1, time2)
    time1.overlaps?(time2)
  end

  def weekly_schedule
    days = (0...6).to_a.map { [] }

    events.each do |event|
      # TODO: push time on to schedule
      days[event.wday] << event
    end

    days
  end
end
