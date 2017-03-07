require 'rails_helper'

RSpec.describe ProcessLedgersJob, vcr: {record: :once} do

  it "is does not retry" do
    expect(described_class.sidekiq_options["retry"]).to eq false
  end

  describe "#perform" do
    let(:client) do
      Hyperclient.new(ENV["HORIZON_URL"]) do |c|
        c.options[:async] = false
      end
    end
    let(:latest_sequence) do
      client.history_latest_ledger - described_class::BATCH_SIZE
    end

    context "batch_size doesn't go beyong horizon history_latest_ledger" do
      before do
        create(:ledger, sequence: latest_sequence)
      end

      it "creates ledger records with the right sequence, #{described_class::BATCH_SIZE} (default) at a time, not surpassing the horizon's history_latest_ledger" do
        described_class.new.perform(2)

        (latest_sequence..latest_sequence+2).each do |n|
          expect(CreateLedgerJob).to have_been_enqueued.with(n)
        end
      end
    end

    context "batch_size brings it later than what horizon has" do
      before do
        create(:ledger, sequence: latest_sequence)
      end

      it "creates ledgers until horizon's history_latest_ledger" do
        described_class.new.perform(8)

        (latest_sequence..client.history_latest_ledger).each do |n|
          expect(CreateLedgerJob).to have_been_enqueued.with(n)
        end
      end
    end

    context "no ledgers exist" do
      it "starts from 1" do
        described_class.new.perform(5)

        (1..5).each do |n|
          expect(CreateLedgerJob).to have_been_enqueued.with(n)
        end
      end
    end
  end

end
