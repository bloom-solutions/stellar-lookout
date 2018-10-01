require 'rails_helper'

RSpec.describe ProcessWardOperation do

  let(:ward) { build_stubbed(:ward, address: "G-ADD") }
  let(:txn) { build_stubbed(:txn, body: {txn_body: "body"}) }
  let(:operation) do
    build_stubbed(:operation, txn: txn, body: {op_body: "body"})
  end

  it(
    "publishes details to #{described_class::EVENTS_CHANNEL} channel and"\
    "the address specific-channel"
  ) do
    described_class.(ward, operation)

    # /address specific backlog
    address_backlog = MessageBus.backlog("/events-G-ADD", 0)
    expect(address_backlog.size).to eq 1
    expect(address_backlog[0]["data"]["operation"]["op_body"]).to eq "body"
    expect(address_backlog[0]["data"]["transaction"]["txn_body"]).to eq "body"

    # all events
    address_backlog = MessageBus.backlog("/events", 0)
    expect(address_backlog.size).to eq 1
    expect(address_backlog[0]["data"]["operation"]["op_body"]).to eq "body"
    expect(address_backlog[0]["data"]["transaction"]["txn_body"]).to eq "body"
  end

end
