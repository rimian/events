require 'spec_helper'

RSpec.describe Schedule do
  let(:subject) { described_class.new }

  let(:events) do
    [
      Event.new('2018-12-19 16:00:00', '2018-12-19 17:00:00'),
      Event.new('2018-12-20 9:30:00', '2018-12-20 11:30:00'),
      Event.new('2018-12-21 9:00:00', '2018-12-20 11:00:00')
    ]
  end

  let(:booked) do
    [
      Event.new('2018-12-19 16:00:00', '2018-12-19 17:00:00'),
      Event.new('2018-12-20 9:00:00', '2018-12-20 10:00:00')
    ]
  end

  before do
    subject.events = events
    subject.booked = booked
  end

  it { should respond_to :booked }
  it { should respond_to :not_booked }

  it 'overlaps' do
    expect(subject.overlaps?((2...9), (7..11))).to eq true
  end

  it 'has a list of events' do
    expect(subject.events).to eq events
  end

  describe 'booked schedule' do
    it 'has an event on Sunday' do
      event = double('Event', wday: 0)
      subject.events = [event]
      aggregate_failures do
        expect(subject.weekly_schedule.first).not_to be_empty
        expect(subject.weekly_schedule.reject(&:empty?).length).to eq 1
      end
    end

    it 'has two events on Monday' do
      event = double('Event', wday: 1)
      subject.events = [event, event]
      aggregate_failures do
        expect(subject.weekly_schedule[1].length).to eq 2
        expect(subject.weekly_schedule.reject(&:empty?).length).to eq 1
      end
    end
  end
end
