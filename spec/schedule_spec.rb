require 'spec_helper'

RSpec.describe Schedule do
  let(:subject) { described_class.new }

  it { should respond_to :booked }
  it { should respond_to :events }

  it 'overlaps' do
    # TODO: move this into event
    expect(subject.overlaps?((2...9), (7..11))).to eq true
  end

  describe 'booked schedule' do
    it 'has an event on Sunday' do
      event = double('Event', wday: 0)
      subject.booked = [event]
      aggregate_failures do
        expect(subject.weekly_schedule.first).not_to be_empty
        expect(subject.weekly_schedule.reject(&:empty?).length).to eq 1
      end
    end

    it 'has two events on Monday' do
      event = double('Event', wday: 1)
      subject.booked = [event, event]
      aggregate_failures do
        expect(subject.weekly_schedule[1].length).to eq 2
        expect(subject.weekly_schedule.reject(&:empty?).length).to eq 1
      end
    end
  end
end
