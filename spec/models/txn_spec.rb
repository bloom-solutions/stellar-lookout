require 'rails_helper'

RSpec.describe Txn do

  describe "associations" do
    it do
      is_expected.to belong_to(:ledger).with_primary_key(:sequence).
        with_foreign_key(:ledger_sequence)
    end
    it do
      is_expected.to have_many(:operations).dependent(:destroy).
        with_primary_key(:external_id).
        with_foreign_key(:txn_external_id)
    end
  end

end
