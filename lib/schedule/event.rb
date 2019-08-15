class Event
  attr_accessor :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = DateTime.parse(start_date)
    @end_date = DateTime.parse(end_date)
  end

  def to_s
    "start: #{start_date}, end: #{end_date}"
  end
end
