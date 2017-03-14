require 'rails_helper'

RSpec.describe ProcessLedgersJob, vcr: {record: :once} do

  describe "#perform" do
    before do
      create(:ledger, sequence: 5, paging_token: "21474836480")
    end

    it "starts with the paging_token / cursor and walks through the list of ledgers" do
      described_class.new.perform("21474836480")

      ledger_105 = Ledger.find_by(sequence: 105)
      expect(ledger_105).to be_present
      expect(ledger_105.paging_token).to eq "450971566080"
    end
  end

end
