require 'rails_helper'

module ProcessingLedgerTxns
  RSpec.describe CreateTxns, vcr: {record: :once} do

    let!(:ward_1) do
      create(:ward, {
        address: "GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB",
      })
    end
    let(:ledger_sequence) { 3 }
    let!(:ledger) { create(:ledger, sequence: ledger_sequence) }
    let(:client) { InitClient.execute(ledger_sequence: ledger.sequence).client }

    it "creates non-existing txns" do
      expect(ledger.txns.count).to be_zero

      described_class.execute(client: client, ledger_sequence: ledger_sequence)

      expected_txn_ids =
        %w(3389e9f0f1a65f19736cacf544c2e825313e8447f569233bb8db39aa607c8889)
      expected_txns = ledger.txns.where(external_id: expected_txn_ids)
      expect(expected_txns.count).to eq 1

      described_class.execute(client: client, ledger_sequence: ledger_sequence)

      expect(ledger.txns.count).to eq 1
    end
  end

end
