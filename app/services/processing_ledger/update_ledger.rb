module ProcessingLedger
  class UpdateLedger

    extend LightService::Action
    expects :client, :ledger

    executed do |c|
      client = c.client
      c.ledger.update_attributes!(
        external_id: client.id,
        operation_count: client.operation_count,
      )
    end

  end
end
