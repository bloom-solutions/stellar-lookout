require 'rails_helper'

RSpec.describe BackwardSyncLedgers do

  it "calls actions in order" do
    actions = [
      BackwardSyncing::SyncNeeded,
      BackwardSyncing::GetLatestSequence,
      GetPagingToken,
      EnqueueProcessLedgers,
    ]

    ctx = LightService::Context.new

    actions.each do |action|
      expect(action).to receive(:execute).with(ctx).and_return(ctx)
    end

    described_class.()
  end

end
