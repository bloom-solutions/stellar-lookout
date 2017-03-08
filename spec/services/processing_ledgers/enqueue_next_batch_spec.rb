require 'rails_helper'

module ProcessingLedgers
  RSpec.describe EnqueueNextBatch do

    context "next batch_step is less than the batch size and there are remote_ledgers" do
      let(:remote_ledgers) do
        [
          { "sequence" => 9 },
          { "sequence" => 10 },
        ]
      end

      it "enqueues ProcessLedgersJob" do
        described_class.(0, remote_ledgers)
        expect(ProcessLedgersJob).to have_been_enqueued.with(1, 10)
      end
    end

    context "next batch_step is more than the batch size and there are remote_ledgers" do
      let(:remote_ledgers) do
        [
          { "sequence" => 9 },
          { "sequence" => 10 },
        ]
      end

      it "enqueues ProcessLedgersJob" do
        described_class.(1, remote_ledgers)
        expect(ProcessLedgersJob).to_not have_been_enqueued
      end
    end

    context "next batch_step is less than the batch size but there are no remote_ledgers" do
      let(:remote_ledgers) { [] }

      it "enqueues ProcessLedgersJob" do
        described_class.(0, remote_ledgers)
        expect(ProcessLedgersJob).to_not have_been_enqueued
      end
    end

  end
end
