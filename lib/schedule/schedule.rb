
class Schedule
  attr_reader :already_booked, :available
  attr_writer :events

  def available
    @events
  end
end
