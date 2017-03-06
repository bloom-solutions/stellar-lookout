require 'rails_helper'

module ProcessingLedgerOperations
  RSpec.describe CreateOperations, vcr: {record: :once} do

    let!(:ward_1) do
      create(:ward, {
        address: "GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB",
      })
    end
    let(:ledger_sequence) { 3 }
    let!(:ledger) { create(:ledger, sequence: ledger_sequence) }
    let(:client) { InitClient.execute(ledger_sequence: ledger.sequence).client }

    it "creates non-existing operations and passes work to ProcessWardOperationJob" do
      expect(ledger.operations.count).to be_zero

      # expect(EnqueueProcessWardOperations).to receive(:call).with(operation)
      # ward_1_operation_ids = %w(12884905986 12884905987)
      # ward_1_operation_ids.each do |operation_id|
      #   expect(ProcessWardOperationJob).to receive(:perform_later).
      #     with(ward_1.id, operation_id)
      # end

      described_class.execute(client: client, ledger_sequence: ledger_sequence)

      expected_operation_ids = %w(12884905985 12884905986 12884905987)
      expected_operations =
        ledger.operations.where(external_id: expected_operation_ids)
      expect(expected_operations.count).to eq 3

      # expect(ProcessWardOperationJob).to_not receive(:perform_later)

      described_class.execute(client: client, ledger_sequence: ledger_sequence)

      expect(ledger.operations.count).to eq 3
    end
  end

end
