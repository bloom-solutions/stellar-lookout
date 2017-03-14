require 'rails_helper'

module ForwardSyncing
  RSpec.describe GetLatestSequence do

    context "there are no local ledgers" do
      it "returns the latest sequence in horizon" do
        expect(GetLatestHorizonSequence).to receive(:call).and_return(200)
        resulting_ctx = described_class.execute
        expect(resulting_ctx.sequence).to eq 200
      end
    end

    context "there are local ledgers" do
      let!(:ledger_1) { create(:ledger, sequence: 3000) }
      let!(:ledger_2) { create(:ledger, sequence: 2000) }

      it "returns the latest sequence in the db" do
        resulting_ctx = described_class.execute
        expect(resulting_ctx.sequence).to eq 3000
      end
    end

  end
end
