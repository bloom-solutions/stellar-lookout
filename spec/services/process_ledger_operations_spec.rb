require 'rails_helper'

RSpec.describe ProcessLedgerOperations do

  it "calls actions in order" do
    actions = [
      ProcessingLedgerOperations::InitClient,
      ProcessingLedgerOperations::CreateOperations,
    ]

    ctx = LightService::Context.new(ledger_sequence: 1)

    actions.each do |action|
      expect(action).to receive(:execute).with(ctx).and_return(ctx)
    end

    described_class.(1)
  end

end
