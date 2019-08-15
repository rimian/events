class Schedule
  attr_accessor :booked, :events
  attr_reader :not_booked

  def overlaps?(r1, r2)
    r1.overlaps?(r2)
  end
end
