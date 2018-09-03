class ProcessWardOperation

  def self.call(ward, operation)
    channel = "/#{ward.address}"
    data = {
      operation: operation.body,
      transaction: operation.txn.body,
    }
    MessageBus.publish(channel, data)
  end

end
