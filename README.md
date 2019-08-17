# Schedule

This gem takes dates strings and checks if they collide with a pre-booked schedule.

See usage below.

 A week is insignificant, day and time is significant. Meaning that an event on Friday 21st Dec, 1:00 - 1:30pm will clash with an event on Friday 28th Dec – 1:00-3:00pm, as they are on the same day of the week and overlap time despite being in separate weeks.

# Installation

`gem install schedule`

## Usage

`pry`

`pry(main)> require 'schedule'` # true

### Add some dates:

Create an event:

Where start and end dates are valid date strings that can be parsed by `DateTime`

```
schedule = Schedule.new
available = Event.new(start_state, end_date)
booked = Event.new(start_state, end_date)
```

```
schedule.events << available
schedule.booked << booked
```

Run it:

`schedule.not_booked`

Human readable:

`schedule.not_booked.map(&:to_s)`

##Exanple

```
already_booked = [
  Event.new('2018-12-19 16:00:00', '2018-12-19 17:00:00'),
  Event.new('2018-12-20 9:00:00', '2018-12-20 10:00:00')
]

available = [
  Event.new('2018-12-19 16:00:00', '2018-12-19 17:00:00'),
  Event.new('2018-12-20 9:30:00', '2018-12-20 11:30:00'),
  Event.new('2018-12-21 9:00:00', '2018-12-20 11:00:00')
]

schedule = Schedule.new
schedule.events = available
schedule.booked = already_booked
schedule.not_booked.map(&:to_s) # ["start: 2018-12-21 09:00:00, end: 2018-12-20 11:00:00"]
```

## Assumptions

* The date time format can be parsed by `DateTime`
* The start date is before the end date
* The dates can be in the past and the future
* It's a local time zone.
* The events only have attributes: start and end dates.
* The list of events is formatted correctly
* An event has a start and end on the same day

# Improvements

* Parse the dates and send `DateTime` to `Events`
* Support events on more than one day
* Fix the mistake in the data in the example.
* Validate events 
