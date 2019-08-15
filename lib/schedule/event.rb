class Event
  attr_accessor :start_date, :end_date

  def initialize(start_date, end_date)
    @start_date = DateTime.parse(start_date)
    @end_date = DateTime.parse(end_date)
  end

  def to_s
    format = '%Y-%m-%d %T'
    "start: #{start_date.strftime(format)}, end: #{end_date.strftime(format)}"
  end

  def wday
    start_date.wday
  end

  def to_range
    (seconds(start_date)...seconds(end_date))
  end

  private

  def seconds(date)
    (date.hour.hours + date.minute.minutes + date.second.seconds).seconds
  end
end
