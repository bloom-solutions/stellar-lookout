require 'rails_helper'

RSpec.describe Operation do

  describe "associations" do
    it do
      is_expected.to belong_to(:ledger).
        with_primary_key(:sequence).
        with_foreign_key(:ledger_sequence)
    end
  end

end
