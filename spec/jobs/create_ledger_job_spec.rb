require 'rails_helper'

RSpec.describe CreateLedgerJob do

  describe "#perform" do
    context "ledger record does not exist with the sequence" do
      it "creates the ledger model and enqueues ProcessLedgerJob" do
        described_class.new.perform(2)

        expect(Ledger.where(sequence: 2)).to be_present
        expect(ProcessLedgerJob).to have_been_enqueued.with(2)
      end
    end
  end

end
