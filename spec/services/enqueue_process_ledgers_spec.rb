require 'rails_helper'

RSpec.describe EnqueueProcessLedgers do

  it "enqueues ProcessLedgersJob given the sequence in the context" do
    described_class.execute(paging_token: "41139640597479424")
    expect(ProcessLedgersJob).to have_been_enqueued.with("41139640597479424")
  end

end
