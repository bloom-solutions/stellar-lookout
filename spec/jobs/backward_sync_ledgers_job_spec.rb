require 'rails_helper'

RSpec.describe BackwardSyncLedgersJob do

  it "delegates to BackwardSyncLedgers" do
    expect(BackwardSyncLedgers).to receive(:call)
    described_class.new.perform
  end

end
