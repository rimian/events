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

`schedule = Schedule.new`
`available = Event.new(start_state, end_date)`
`booked = Event.new(start_state, end_date)`

```
schedule.events << available
schedule.booked << booked
```

Run it:

`schedule.not_booked`

## Assumptions

* The date time format can be parsed by `DateTime`
* 24 hour time is used
* The start date is before the end date
* The dates can be in the past and the future
* It's a local time zone.
* The events only have attributes: start and end dates.
* The list of events is formatted correctly
* An event has a start and end on the same day

# Improvements

* Parse the dates and send `DateTime` to `Events`
* Support events on more than one day
