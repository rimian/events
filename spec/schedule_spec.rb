require 'spec_helper'

RSpec.describe Schedule do
  it "has a list of already booked events" do
    expect(subject).to respond_to :already_booked
  end

  it "has a list of available events" do
    expect(subject).to respond_to :available
  end
end
