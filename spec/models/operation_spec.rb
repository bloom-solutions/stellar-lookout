require 'rails_helper'

RSpec.describe Operation do

  describe "associations" do
    it do
      is_expected.to belong_to(:ledger).
        with_primary_key(:sequence).
        with_foreign_key(:ledger_sequence)
    end
  end

  describe ".watched_by" do
    let(:ward_1) do
      create(:ward, {
        address: "GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7",
      })
    end
    let(:ward_2) { create(:ward, address: "another") }
    Operation::ADDRESS_FIELDS.each_with_index do |field, i|
      let!(:"operation_#{i+1}") do
        create(:operation, {
          body: {
            field => "GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7",
          }
        })
      end
    end
    let(:expected_operations) do
      (1..Operation::ADDRESS_FIELDS.length).map do |n|
        send(:"operation_#{n}")
      end
    end

    it "includes only operations that participated in" do
      expect(described_class.watched_by(ward_1)).
        to match_array(expected_operations)
      expect(described_class.watched_by(ward_2)).to be_empty
    end
  end

end
