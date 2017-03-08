require 'rails_helper'

module ProcessingLedger
  RSpec.describe CreateOrUpdateLedger do

    let(:remote_ledger_hash) do
      {
        _links: {
          self: {
            href: "https://horizon.stellar.org/ledgers/1"
          },
          transactions: {
            href: "https://horizon.stellar.org/ledgers/1/transactions{?cursor,limit,order}",
            templated: true
          },
          operations: {
            href: "https://horizon.stellar.org/ledgers/1/operations{?cursor,limit,order}",
            templated: true
          },
          payments: {
            href: "https://horizon.stellar.org/ledgers/1/payments{?cursor,limit,order}",
            templated: true
          },
          effects: {
            href: "https://horizon.stellar.org/ledgers/1/effects{?cursor,limit,order}",
            templated: true
          }
        },
        id: "39c2a3cd4141b2853e70d84601faa44744660334b48f3228e0309342e3f4eb48",
        paging_token: "4294967296",
        hash: "39c2a3cd4141b2853e70d84601faa44744660334b48f3228e0309342e3f4eb48",
        sequence: 1,
        transaction_count: 0,
        operation_count: 0,
        closed_at: "1970-01-01T00:00:00Z",
        total_coins: "100000000000.0000000",
        fee_pool: "0.0000000",
        base_fee: 100,
        base_reserve: "10.0000000",
        max_tx_set_size: 100
      }.with_indifferent_access
    end

    it "creates a local ledger based on the remote ledger" do
      resulting_ctx =
        described_class.execute(remote_ledger_hash: remote_ledger_hash)

      ledger = Ledger.find_by(sequence: 1)
      expect(resulting_ctx.ledger).to eq ledger

      expect(ledger).to be_present
      expect(ledger.operation_count).to be_zero

      expect { described_class.execute(remote_ledger_hash: remote_ledger_hash) }.
        to_not change(Ledger, :count)
    end

  end
end
