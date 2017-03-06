require 'rails_helper'

module ProcessingLedger
  RSpec.describe FindLedger do

    let(:ledger) { build_stubbed(:ledger) }

    it "sets the ledger with the sequence" do
      expect(Ledger).to receive(:find_by!).with(sequence: 2).and_return(ledger)
      resulting_ctx = described_class.execute(ledger_sequence: 2)
      expect(resulting_ctx.ledger).to eq ledger
    end

  end
end
