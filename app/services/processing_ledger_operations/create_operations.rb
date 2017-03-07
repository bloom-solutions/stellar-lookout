module ProcessingLedgerOperations
  class CreateOperations

    extend LightService::Action
    expects :client, :ledger_sequence

    executed do |c|
      # TODO be able to manage instances where there are more ops than what fit
      # in the page
      c.client.records.each do |remote_operation|
        ProcessOperation.execute({
          remote_operation: remote_operation,
          ledger_sequence: c.ledger_sequence,
        })
      end
    end

  end
end
