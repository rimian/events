require 'spec_helper'

RSpec.describe Event do
  let(:subject) { described_class.new('2018-12-19 16:00:00', '2018-12-19 17:00:00') }

  it "has a start" do
    expect(subject).to respond_to :start_date
  end

  it "has a end" do
    expect(subject).to respond_to :end_date
  end

  it "is something" do
    event = described_class.new('2018-12-19 16:00:00', '2018-12-19 17:00:00')
  end
end
