require 'rails_helper'

module ProcessingLedger
  RSpec.describe EnqueueProcessLedgerTxns do

    let(:ledger) { create(:ledger, sequence: 3, transaction_count: 2) }

    context "local txns is less than the remote" do
      let!(:op_1) { create(:txn, ledger: ledger) }

      it "enqueues a ProcessLedgerTxnsJob" do
        described_class.execute(ledger: ledger)
        expect(ProcessLedgerTxnsJob).to have_been_enqueued.with(3)
      end
    end

    context "local txn count is the same as remote" do
      let!(:op_1) { create(:txn, ledger: ledger) }
      let!(:op_2) { create(:txn, ledger: ledger) }

      it "does nothing" do
        described_class.execute(ledger: ledger)
        expect(ProcessLedgerTxnsJob).to_not have_been_enqueued
      end
    end

  end
end
