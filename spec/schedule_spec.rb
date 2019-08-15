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

  it 'overlaps' do
    expect(subject.overlaps?((2...9), (7..11))).to eq true
  end

  it 'has a list of events' do
    expect(subject.events).to eq events
  end

  it { should respond_to :booked }
  it { should respond_to :not_booked }
end
