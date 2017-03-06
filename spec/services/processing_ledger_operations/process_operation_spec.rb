require 'rails_helper'

module ProcessingLedgerOperations
  RSpec.describe ProcessOperation do
    
    let(:remote_operation) do
      {
        _links: {
          self: {
            href: "https://horizon.stellar.org/operations/12884905986"
          },
          transaction: {
            href: "https://horizon.stellar.org/transactions/3389e9f0f1a65f19736cacf544c2e825313e8447f569233bb8db39aa607c8889"
          },
          effects: {
            href: "https://horizon.stellar.org/operations/12884905986/effects"
          },
          succeeds: {
            href: "https://horizon.stellar.org/effects?order=desc&cursor=12884905986"
          },
          precedes: {
            href: "https://horizon.stellar.org/effects?order=asc&cursor=12884905986"
          }
        },
        id: "12884905986",
        paging_token: "12884905986",
        source_account: "GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7",
        type: "payment",
        type_i: 1,
        asset_type: "native",
        from: "GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7",
        to: "GALPCCZN4YXA3YMJHKL6CVIECKPLJJCTVMSNYWBTKJW4K5HQLYLDMZTB",
        amount: "99999999959.9999700"
      }
    end

    context "remote operation exists" do
      let!(:ledger) { create(:ledger, sequence: 3) }
      before do
        create(:operation, external_id: "12884905986", ledger: ledger)
      end

      it "does nothing" do
        described_class.execute({
          remote_operation: remote_operation,
          ledger_sequence: 3,
        })
        expect(ProcessWardOperationJob).to_not have_been_enqueued
      end
    end

    context "remote operation does not exist" do
      let!(:ward_1) do
        create(:ward, {
          address: "GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7",
        })
      end
      let!(:ward_1) do
        create(:ward, {
          address: "GAAZI4TCR3TY5OJHCTJC2A4QSY6CJWJH5IAJTGKIN2ER7LBNVKOCCWN7",
        })
      end
      let(:operation) { build_stubbed(:operation) }

      it "creates the operation and enqueues ProcessWardOperationJob per ward interested" do
        expect(Operation).to receive(:create!).with(
          external_id: "12884905986",
          ledger_sequence: 3,
          body: remote_operation.to_json,
        ).and_return(operation)

        expect(EnqueueProcessWardOperationJobs).to receive(:call).
          with(operation)

        described_class.execute({
          remote_operation: remote_operation,
          ledger_sequence: 3,
        })
      end
    end

  end
end
