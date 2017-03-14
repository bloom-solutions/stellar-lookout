require 'rails_helper'

RSpec.describe ProcessTxnOperations do

  let(:txn) { build_stubbed(:txn) }

  it "calls actions in order" do
    actions = [
      ProcessingTxnOperations::InitClient,
      ProcessingTxnOperations::CreateOperations,
    ]

    ctx = LightService::Context.new(txn: txn)

    actions.each do |action|
      expect(action).to receive(:execute).with(ctx).and_return(ctx)
    end

    described_class.(txn)
  end

end
