require 'rails_helper'

module ProcessingLedger
  RSpec.describe UpdateLedger, vcr: {record: :once} do

    let(:sequence) { 7874 }
    let(:client) { InitClient.execute(ledger_sequence: sequence).client }
    let(:ledger) { create(:ledger, sequence: sequence) }

    it "updates the ledger with operation_count and remote id" do
      expect(ledger).to receive(:update_attributes!).with(
        external_id: "6e687d0f4b4ab21ee4ce453ed70137f00af9c068a29d29d79e011522189c8560",
        operation_count: 1,
      )
      described_class.execute({
        client: client,
        ledger: ledger,
      })
    end

  end
end
