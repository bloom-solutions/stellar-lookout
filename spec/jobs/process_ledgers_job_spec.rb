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
    let(:history_latest_ledger) { client.history_latest_ledger }
    let(:latest_sequence) { history_latest_ledger - 5 }

    before do
      create(:ledger, sequence: latest_sequence)
    end

    it "creates ledger records with the right sequence" do
      (latest_sequence..history_latest_ledger).each do |n|
        expect(CreateLedgerJob).to receive(:perform_later).with(n)
      end

      described_class.new.perform(history_latest_ledger)
    end
  end

end
