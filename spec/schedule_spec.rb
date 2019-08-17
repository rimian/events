require 'spec_helper'

RSpec.describe Schedule do
  let(:subject) { described_class.new }

  it { should respond_to :booked }
  it { should respond_to :events }

  describe '#not_booked' do
    it 'has nothing booked' do
      expect(subject.not_booked).to be_empty
    end

    it 'has all the events when nothing is booked' do
      subject.events << Event.new('2018-12-19 16:00:00', '2018-12-19 17:00:00')
      subject.booked = []
      expect(subject.not_booked).to eq subject.events
    end

    it 'does not clash when the events do not clash' do
      subject.events << Event.new('2018-12-19 16:00:00', '2018-12-19 17:00:00')
      subject.booked << Event.new('2018-12-19 18:00:00', '2018-12-19 19:00:00')
      expect(subject.not_booked).to eq subject.events
    end

    it 'does not show the event that clashes' do
      subject.events << Event.new('2018-12-19 16:00:00', '2018-12-19 17:00:00')
      subject.booked << Event.new('2018-12-19 16:15:00', '2018-12-19 15:00:00')
      expect(subject.not_booked).to be_empty
    end
  end

  describe 'booked schedule' do
    it 'has an empty schedule' do
      week = subject.weekly_schedule
      aggregate_failures do
        expect(week[:sun]).to be_empty
        expect(week[:mon]).to be_empty
        expect(week[:tue]).to be_empty
        expect(week[:wed]).to be_empty
        expect(week[:thu]).to be_empty
        expect(week[:fri]).to be_empty
        expect(week[:sat]).to be_empty
      end
    end

    it 'has an event on Sunday' do
      subject.booked << double('Event', week_day: 'Sun', time_to_range: nil)
      expect(subject.weekly_schedule[:sun]).not_to be_empty
    end

    it 'has two events on Monday' do
      2.times { subject.booked << double('Event', week_day: 'Mon', time_to_range: nil) }
      expect(subject.weekly_schedule[:mon].length).to eq 2
    end

    it 'has the time period' do
      subject.booked << double('Event', week_day: 'Sat', time_to_range: (0...8))
      aggregate_failures do
        expect(subject.weekly_schedule[:sat].first).to eq((0...8))
        expect(subject.weekly_schedule[:sat].length).to eq 1
      end
    end
  end

  describe '#clashes?' do
    it 'clashes on the same time on the same week day' do
      event = double('Event', week_day: 'Mon')
      expect(subject).to receive(:overlaps_time?).and_return(true)
      expect(subject.clashes?(event, event)).to eq true
    end

    it 'does not clash on a different time' do
      event = double('Event', week_day: 'Mon')
      expect(subject).to receive(:overlaps_time?).and_return(false)
      expect(subject.clashes?(event, event)).to eq false
    end

    it 'does not clash on a different days' do
      event_one = double('Event', week_day: 'Mon')
      event_two = double('Event', week_day: 'Fri')
      expect(subject.clashes?(event_one, event_two)).to eq false
    end
  end

  describe '#overlaps_time?' do
    it 'overlaps times on the same actual day' do
      event_one = Event.new('2018-12-19 16:00:00', '2018-12-19 17:00:00')
      event_two = Event.new('2018-12-19 16:30:00', '2018-12-19 17:30:00')
      expect(subject.overlaps_time?(event_one, event_two)).to eq true
    end

    it 'overlaps times on any day' do
      event_one = Event.new('2018-12-19 16:00:00', '2018-12-19 17:00:00')
      event_two = Event.new('2018-12-20 16:30:00', '2018-12-20 17:30:00')
      expect(subject.overlaps_time?(event_one, event_two)).to eq true
    end

    it 'does not everlap different times' do
      event_one = Event.new('2018-12-19 16:00:00', '2018-12-19 17:00:00')
      event_two = Event.new('2018-12-19 10:30:00', '2018-12-19 11:30:00')
      expect(subject.overlaps_time?(event_one, event_two)).to eq false
    end

    it 'does not everlap adjacent times' do
      event_one = Event.new('2018-12-19 16:00:00', '2018-12-19 17:00:00')
      event_two = Event.new('2018-12-19 17:00:00', '2018-12-19 18:30:00')
      expect(subject.overlaps_time?(event_one, event_two)).to eq false
    end
  end
end
