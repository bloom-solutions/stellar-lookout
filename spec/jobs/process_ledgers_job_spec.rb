require 'rails_helper'

RSpec.describe ProcessLedgersJob, vcr: {record: :once} do

  describe "#perform" do
    context "no ledgers exist" do
      it "starts without a cursor and walks through the list of ledgers until `batch_size` page" do
        described_class.new.perform

        expect(Ledger.pluck(:sequence).to_set).to eq (1..100).to_set

        ledger_3 = Ledger.find_by(sequence: 3)
        expect(ledger_3.external_id).
          to eq "ec168d452542589dbc2d0eb6d58c74b9bb2ccb93bba879a3b3fa73fdfa730182"
        expect(ledger_3.paging_token).to eq "12884901888"
        expect(ledger_3.operation_count).to eq 3

        ledger_10 = Ledger.find_by(sequence: 10)
        expect(ledger_10.external_id).
          to eq "31c33314a9d6f1d1e07040029f56403fc410829a45dfe9cc662c6b2dce8f53b3"
        expect(ledger_10.paging_token).to eq "42949672960"
        expect(ledger_10.operation_count).to eq 0

        ledger_20 = Ledger.find_by(sequence: 20)
        expect(ledger_20.external_id).
          to eq "47cc6fa49769a6c806ef8c0c0efadd572f3843171561e9cb6adc5c3f7daff10c"
        expect(ledger_20.paging_token).to eq "85899345920"
        expect(ledger_20.operation_count).to eq 0

        ledger_100 = Ledger.find_by(sequence: 100)
        expect(ledger_100.paging_token).to eq "429496729600"
        expect(ledger_100.operation_count).to eq 0

        expect(described_class).to have_been_enqueued.
          with(1, ledger_100.sequence)
      end
    end

    context "ledgers exist" do
      before do
        create(:ledger, sequence: 5, paging_token: "21474836480")
      end

      it "starts with the latest ledger's cursor and walks through the list of ledgers until `batch_size` page" do
        described_class.new.perform

        ledger_105 = Ledger.find_by(sequence: 105)
        expect(ledger_105).to be_present
        expect(ledger_105.paging_token).to eq "450971566080"

        expect(described_class).to have_been_enqueued.
          with(1, ledger_105.sequence)
      end
    end
  end

end
