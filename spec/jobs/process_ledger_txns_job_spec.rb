require 'rails_helper'

RSpec.describe ProcessLedgerTxnsJob do

  it "delegates work to ProcessLedgerTxns" do
    expect(ProcessLedgerTxns).to receive(:call).with(3)
    described_class.new.perform(3)
  end

end
