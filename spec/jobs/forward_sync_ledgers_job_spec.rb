require 'rails_helper'

RSpec.describe ForwardSyncLedgersJob do

  it "delegates to ForwardSyncLedgers" do
    expect(ForwardSyncLedgers).to receive(:call)
    described_class.new.perform
  end

end
