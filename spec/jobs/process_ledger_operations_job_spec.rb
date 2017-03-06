require 'rails_helper'

RSpec.describe ProcessLedgerOperationsJob do

  it "delegates work to ProcessLedgerOperations" do
    expect(ProcessLedgerOperations).to receive(:call).with(77)
    described_class.new.perform(77)
  end

end
