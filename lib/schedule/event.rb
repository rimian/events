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

  private

  def seconds(hours, minutes, seconds)
    (hours.hours + minutes.minutes + seconds.seconds).seconds
  end
end
