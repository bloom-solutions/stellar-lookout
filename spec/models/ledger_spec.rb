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

end
