require 'rails_helper'

RSpec.describe Ledger do

  describe "associations" do
    it do
      is_expected.to have_many(:operations).
        with_primary_key(:sequence).
        with_foreign_key(:ledger_sequence).
        dependent(:destroy)
    end
  end

  describe ".sequence_before" do
    let!(:ledger_1) { create(:ledger, sequence: 3) }
    let!(:ledger_2) { create(:ledger, sequence: 4) }
    let!(:ledger_3) { create(:ledger, sequence: 5) }

    it "returns the ledgers with the sequence before the given" do
      expect(described_class.sequence_before(4)).
        to match_array([ledger_1])
      expect(described_class.sequence_before(5)).
        to match_array([ledger_1, ledger_2])
    end
  end

end
