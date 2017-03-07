require 'rails_helper'

RSpec.describe WardAfterCreateJob do

  let!(:ward) { create(:ward, address: "address") }
  let!(:operation_1) do
    create(:operation, body: {source_account: ward.address})
  end
  let!(:operation_2) do
    create(:operation, body: {source_account: "something_else"})
  end

  it "delegates work to ProcessWardOperationJob to for each operation the ward cares about" do
    described_class.new.perform(ward)
    expect(ProcessWardOperationJob).to have_been_enqueued.with(ward, operation_1)
  end

end
