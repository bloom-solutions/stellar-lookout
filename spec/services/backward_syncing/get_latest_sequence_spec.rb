require 'rails_helper'

module BackwardSyncing
  RSpec.describe GetLatestSequence do

    context "there are no local ledgers" do
      it "returns nil" do
        resulting_ctx = described_class.execute
        expect(resulting_ctx.sequence).to be_nil
      end
    end

    context "there are local ledgers created by ForwardSyncLedgers" do
      before do
        Timecop.travel 1.minute.ago
        create(:ledger, sequence: 3000)
        Timecop.return
      end

      it "returns the latest sequence in the db" do
        resulting_ctx = described_class.execute
        expect(resulting_ctx.sequence).to be_nil
      end
    end

    context "there are local ledgers created by ForwardSyncLedgers and BackwardSyncLedgers" do
      before do
        Timecop.travel 1.minute.ago
        create(:ledger, sequence: 3000)
        Timecop.return
        create(:ledger, sequence: 11)
        create(:ledger, sequence: 12)
      end

      it "returns the latest sequence in the db" do
        resulting_ctx = described_class.execute
        expect(resulting_ctx.sequence).to eq 12
      end
    end

  end
end
