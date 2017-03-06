module ProcessingLedger
  class EnqueueProcessLedgerOperations

    extend LightService::Action
    expects :ledger

    executed do |c|
      ledger = c.ledger

      next if ledger.operation_count <= ledger.operations.count
      ProcessLedgerOperationsJob.perform_later(ledger.sequence)
    end

  end
end
