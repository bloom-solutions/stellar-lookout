require 'rails_helper'

module ProcessingLedger
  RSpec.describe EnqueueProcessLedgerOperations do

    let(:ledger) { create(:ledger, sequence: 3, operation_count: 2) }

    context "local operation is less than the remote" do
      let!(:op_1) { create(:operation, ledger: ledger) }

      it "enqueues a ProcessLedgerOperationsJob" do
        described_class.execute(ledger: ledger)
        expect(ProcessLedgerOperationsJob).to have_been_enqueued.with(3)
      end
    end

    context "local operation count is the same as remote" do
      let!(:op_1) { create(:operation, ledger: ledger) }
      let!(:op_2) { create(:operation, ledger: ledger) }

      it "does nothing" do
        described_class.execute(ledger: ledger)
        expect(ProcessLedgerOperationsJob).to_not have_been_enqueued
      end
    end

  end
end
