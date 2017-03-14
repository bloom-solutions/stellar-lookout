require 'rails_helper'

module ProcessingLedgerTxns
  RSpec.describe ProcessTxn do

    let(:remote_txn) do
      {
        id: "b49c1b8d1abe6ebcc283040105436e152103e5817fdd4d1a8014ea7f6559b757",
        paging_token: "352208793112576",
        hash: "b49c1b8d1abe6ebcc283040105436e152103e5817fdd4d1a8014ea7f6559b757",
        ledger: 82005,
        created_at: "2017-01-31T15:51:18Z",
        source_account: "GDBNJBSKBZZIIUHL4YNNP2HTSEHHZQMZPJZJIEQTCEA2GLBOTXZOOMIJ",
        source_account_sequence: "280500019134465",
        fee_paid: 100,
        operation_count: 1,
        envelope_xdr: "AAAAAMLUhkoOcoRQ6+Ya1+jzkQ58wZl6cpQSExEBoywunfLnAAAAZAAA/x0AAAABAAAAAAAAAAEAAAAHY2hwXzE5NQAAAAABAAAAAAAAAAEAAAAA8bhd4Eu/48t1eNHE4pTl+J86Gxqem3INrFMqewCcbRsAAAAAAAAAAlQL5AAAAAAAAAAAAS6d8ucAAABAD1FYjPjdTpoELkWRZ+0FnVz7w/y5d/0bdb8fD3sqzFx+bZ+xcQvvH2TS9ow9wkD9YIeH+XBPEFbBTJaQ6ZzLBg==",
        result_xdr: "AAAAAAAAAGQAAAAAAAAAAQAAAAAAAAABAAAAAAAAAAA=",
        result_meta_xdr: "AAAAAAAAAAEAAAADAAAAAQABQFUAAAAAAAAAAMLUhkoOcoRQ6+Ya1+jzkQ58wZl6cpQSExEBoywunfLnAAAAFPRrA5wAAP8dAAAAAQAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAwABPo0AAAAAAAAAAPG4XeBLv+PLdXjRxOKU5fifOhsanptyDaxTKnsAnG0bAAAAF0h26AAAAT6NAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAAAAAAAQABQFUAAAAAAAAAAPG4XeBLv+PLdXjRxOKU5fifOhsanptyDaxTKnsAnG0bAAAAGZyCzAAAAT6NAAAAAAAAAAAAAAAAAAAAAAAAAAABAAAAAAAAAAAAAAAAAAAA",
        fee_meta_xdr: "AAAAAgAAAAMAAP8dAAAAAAAAAADC1IZKDnKEUOvmGtfo85EOfMGZenKUEhMRAaMsLp3y5wAAABdIdugAAAD/HQAAAAAAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAAAAAAEAAUBVAAAAAAAAAADC1IZKDnKEUOvmGtfo85EOfMGZenKUEhMRAaMsLp3y5wAAABdIduecAAD/HQAAAAEAAAAAAAAAAAAAAAAAAAAAAQAAAAAAAAAAAAAAAAAAAA==",
        memo_type: "text",
        memo: "chp_195",
        signatures: [
          "D1FYjPjdTpoELkWRZ+0FnVz7w/y5d/0bdb8fD3sqzFx+bZ+xcQvvH2TS9ow9wkD9YIeH+XBPEFbBTJaQ6ZzLBg=="
        ]
      }
    end

    context "remote txn exists" do
      let!(:txn) do
        create(:txn, {
          external_id: "b49c1b8d1abe6ebcc283040105436e152103e5817fdd4d1a8014ea7f6559b757",
        })
      end

      it "does nothing" do
        described_class.execute({
          remote_txn: remote_txn,
          ledger_sequence: 82005,
        })
        expect(ProcessTxnOperationsJob).to_not have_been_enqueued
      end
    end

    context "local txn does not exist" do
      let(:txn) { build_stubbed(:txn) }

      it "creates the txn" do
        expect(Txn).to receive(:create!).with(
          external_id: "b49c1b8d1abe6ebcc283040105436e152103e5817fdd4d1a8014ea7f6559b757",
          ledger_sequence: 82005,
          body: remote_txn.to_hash,
        ).and_return(txn)

        expect(EnqueueProcessTxnOperations).to receive(:call).with(txn)

        described_class.execute({
          remote_txn: remote_txn,
          ledger_sequence: 82005,
        })
      end
    end

  end
end
