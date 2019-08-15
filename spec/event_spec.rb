require 'spec_helper'

RSpec.describe Event do
  let(:start_date) { '2018-12-19 16:00:00' }
  let(:end_date) { '2018-12-19 17:00:00' }
  let(:subject) { described_class.new(start_date, end_date) }

  it 'has a start date time' do
    expect(subject.start_date).to be_kind_of DateTime
  end

  it 'has an end date time' do
    expect(subject.end_date).to be_kind_of DateTime
  end

  it 'has a Sunday week day' do
    event = described_class.new('Sun, 23 Dec 2018 16:30:01', 'Sun, 23 Dec 2018 16:30:01')
    expect(event.wday).to eq 0
  end

  it 'has a Monday week day' do
    event = described_class.new('24 Dec 2018', '24 Dec 2018')
    expect(event.wday).to eq 1
  end

  describe '#to_s' do
    it 'is a human readable string' do
      expect(subject.to_s).to eq "start: #{start_date}, end: #{end_date}"
    end
  end
end
