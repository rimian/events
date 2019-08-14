require 'spec_helper'

RSpec.describe Event do
  let(:subject) { described_class.new }

  it "has a start date" do
    expect(subject).to respond_to :start
  end

  it "has a end date" do
    expect(subject).to respond_to :end
  end
end
