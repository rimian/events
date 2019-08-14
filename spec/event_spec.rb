require 'spec_helper'

RSpec.describe Event do
  let(:start_date) { '2018-12-19 16:00:00' }
  let(:end_date) { '2018-12-19 17:00:00' }
  let(:subject) { described_class.new(start_date, end_date) }

  it "has a start" do
    expect(subject.start_date).to eq start_date
  end

  it "has a end" do
    expect(subject.end_date).to eq end_date
  end

  describe "#to_s" do
    it "is a human readable string" do
      expect(subject.to_s).to eq "start: #{start_date}, end: #{end_date}"
    end
  end
end
