class ProcessWardOperation

  EVENTS_CHANNEL = "/events"

  def self.call(ward, operation)
    address_channel = "/events-#{ward.address}"
    data = {
      operation: operation.body,
      transaction: operation.txn.body,
    }

    [EVENTS_CHANNEL, address_channel].each do |channel|
      MessageBus.publish(channel, data)
    end
  end

end
