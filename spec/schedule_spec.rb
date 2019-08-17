require 'spec_helper'

RSpec.describe Schedule do
  let(:subject) { described_class.new }

  it { should respond_to :booked }
  it { should respond_to :events }

  describe '#overlaps_time?' do
    it 'overlaps times on the same day' do
      event_1 = Event.new('2018-12-19 16:00:00', '2018-12-19 17:00:00')
      event_2 = Event.new('2018-12-19 16:30:00', '2018-12-19 17:30:00')
      expect(subject.overlaps_time?(event_1, event_2)).to eq true
    end

    it 'overlaps times on any same day' do
      event_1 = Event.new('2018-12-19 16:00:00', '2018-12-19 17:00:00')
      event_2 = Event.new('2018-12-20 16:30:00', '2018-12-20 17:30:00')
      expect(subject.overlaps_time?(event_1, event_2)).to eq true
    end

    it 'does not everlap different times' do
      event_1 = Event.new('2018-12-19 16:00:00', '2018-12-19 17:00:00')
      event_2 = Event.new('2018-12-19 10:30:00', '2018-12-19 11:30:00')
      expect(subject.overlaps_time?(event_1, event_2)).to eq false
    end

    it 'does not everlap adjacent times' do
      event_1 = Event.new('2018-12-19 16:00:00', '2018-12-19 17:00:00')
      event_2 = Event.new('2018-12-19 17:00:00', '2018-12-19 18:30:00')
      expect(subject.overlaps_time?(event_1, event_2)).to eq false
    end
  end

  describe '#not_booked' do
    it 'has nothing booked' do
      expect(subject.not_booked).to be_empty
    end

    it 'has all the events when nothing is booked' do
      subject.events << double('Event', wday: 6)
      subject.events << double('Event', wday: 1)
      subject.booked = []
      expect(subject.not_booked).to eq subject.events
    end

    it 'does not clash when the events do not clash' do
      subject.events << double('Event', wday: 6)
      subject.booked << double('Event', wday: 1)
      expect(subject.not_booked).to eq subject.events
    end

    it 'clashes on Thursday' do
      subject.events << double('Event', wday: 4)
      subject.booked << double('Event', wday: 4)
      expect(subject.not_booked).to be_empty
    end

    it 'clashes on Saturday' do
      subject.events << double('Event', wday: 6)
      subject.booked << double('Event', wday: 6)
      expect(subject.not_booked).to be_empty
    end
  end

  describe 'booked schedule' do
    it 'has an empty schedule' do
      expect(subject.weekly_schedule).to eq([[], [], [], [], [], [], []])
    end

    it 'has an event on Sunday' do
      subject.booked << double('Event', wday: 0)
      aggregate_failures do
        expect(subject.weekly_schedule.first).not_to be_empty
        expect(subject.weekly_schedule.reject(&:empty?).length).to eq 1
      end
    end

    it 'has two events on Monday' do
      2.times { subject.booked << double('Event', wday: 1) }
      aggregate_failures do
        expect(subject.weekly_schedule[1].length).to eq 2
        expect(subject.weekly_schedule.reject(&:empty?).length).to eq 1
      end
    end
  end
end
