require 'rails_helper'

RSpec.describe ForwardSyncLedgers do

  it "calls actions in order" do
    actions = [
      ForwardSyncing::GetLatestSequence,
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
