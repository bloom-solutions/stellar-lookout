require 'rails_helper'

RSpec.describe ProcessLedgerOperations do

  it "calls actions in order" do
    actions = [
      ProcessingLedgerOperations::InitClient,
      ProcessingLedgerOperations::CreateOperations,
    ]
  end
  
end
