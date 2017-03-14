require 'rails_helper'

RSpec.describe ProcessLedgerTxns do

  it "calls actions in order" do
    actions = [
      ProcessingLedgerTxns::InitClient,
      ProcessingLedgerTxns::CreateTxns,
    ]

    ctx = LightService::Context.new(ledger_sequence: 1)

    actions.each do |action|
      expect(action).to receive(:execute).with(ctx).and_return(ctx)
    end

    described_class.(1)
  end

end
