require 'rails_helper'

module ProcessingLedgerTxns
  RSpec.describe EnqueueProcessTxnOperations do

    let(:txn) { create(:txn, operation_count: 2) }

    context "local operation is less than the remote" do
      let!(:op_1) { create(:operation, txn: txn) }

      it "enqueues a ProcessTxnOperationsJob" do
        described_class.(txn)
        expect(ProcessTxnOperationsJob).to have_been_enqueued.with(txn)
      end
    end

    context "local operation count is the same as remote" do
      let!(:op_1) { create(:operation, txn: txn) }
      let!(:op_2) { create(:operation, txn: txn) }

      it "does nothing" do
        described_class.(txn)
        expect(ProcessTxnOperationsJob).to_not have_been_enqueued
      end
    end

  end
end
