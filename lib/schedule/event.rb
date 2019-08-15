class Event
  attr_accessor :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = start_date
    @end_date = end_date
  end

  def to_s
    "start: #{start_date}, end: #{end_date}"
  end
end
