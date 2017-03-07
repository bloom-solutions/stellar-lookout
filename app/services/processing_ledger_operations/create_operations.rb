module ProcessingLedgerOperations
  class CreateOperations

    extend LightService::Action
    expects :client, :ledger_sequence

    executed do |c|
      each_operation(c.client._links.self) do |remote_operation|
        ProcessOperation.execute({
          remote_operation: remote_operation,
          ledger_sequence: c.ledger_sequence,
        })
      end
    end

    def self.each_operation(client, &block)
      client.records.each { |remote_operation| block.yield(remote_operation) }
      self.operations(client._links.next, &block) if client.records.any?
    end

  end
end
