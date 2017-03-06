require 'rails_helper'

RSpec.describe ProcessLedgerJob, vcr: {record: :once} do

  it "delegates work to ProcessLedger" do
    expect(ProcessLedger).to receive(:call).with(7874)
    described_class.new.perform(7874)
  end

end
