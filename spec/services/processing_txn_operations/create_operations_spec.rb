require 'rails_helper'

module ProcessingTxnOperations
  RSpec.describe CreateOperations, vcr: {record: :once} do

    let!(:txn) do
      create(:txn, {
        external_id: "3389e9f0f1a65f19736cacf544c2e825313e8447f569233bb8db39aa607c8889",
      })
    end
    let(:client) { InitClient.execute(txn: txn).client }

    it "creates non-existing operations" do
      expect(txn.operations.count).to be_zero

      described_class.execute(client: client, txn: txn)

      expected_operation_ids = %w(12884905985 12884905986 12884905987)
      expected_operations =
        txn.operations.where(external_id: expected_operation_ids)
      expect(expected_operations.count).to eq 3

      described_class.execute(client: client, txn: txn)

      expect(txn.operations.count).to eq 3
    end
  end

end
