require 'spec_helper'

RSpec.describe Schedule do
  let(:subject) { described_class.new }

  describe "available event" do
    let(:events) {
      []
    }

    before do
      subject.events = events
    end

    it "has a list of available events" do
      expect(subject.available).to eq events
    end
  end

  it "has a list of already booked events" do
    expect(subject).to respond_to :already_booked
  end
end
