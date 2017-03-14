require 'rails_helper'

RSpec.describe ProcessTxnOperationsJob do

  it "delegates work to ProcessTxnOperations" do
    expect(ProcessTxnOperations).to receive(:call).with("b49")
    described_class.new.perform("b49")
  end

end
