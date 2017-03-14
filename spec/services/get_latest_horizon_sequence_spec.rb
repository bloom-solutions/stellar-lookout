require 'rails_helper'

RSpec.describe GetLatestHorizonSequence, vcr: {record: :once} do

  let!(:latest_sequence) do
    Hyperclient.new(ENV["HORIZON_URL"]) do |c|
      c.options[:async] = false
    end.history_latest_ledger
  end

  it "returns the history_latest_ledger sequence in horizon" do
    expect(described_class.()).to be >=(latest_sequence)
  end

end
