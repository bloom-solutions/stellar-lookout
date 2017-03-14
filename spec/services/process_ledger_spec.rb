require 'rails_helper'

RSpec.describe ProcessLedger do

  let(:remote_ledger_hash) { {hash: "1"} }

  it "calls actions in order" do
    actions = [
      ProcessingLedger::CreateOrUpdateLedger,
      ProcessingLedger::EnqueueProcessLedgerTxns,
    ]

    ctx = LightService::Context.new(remote_ledger_hash: remote_ledger_hash)

    actions.each do |action|
      expect(action).to receive(:execute).with(ctx).and_return(ctx)
    end

    described_class.(remote_ledger_hash)
  end

end
