require 'spec_helper'

RSpec.describe Schedule do
  let(:subject) { described_class.new }

  it { should respond_to :booked }
  it { should respond_to :events }

  it 'overlaps' do
    expect(subject.overlaps?((2...9), (7..11))).to eq true
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
