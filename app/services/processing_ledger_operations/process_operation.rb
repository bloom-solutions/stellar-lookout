module ProcessingLedgerOperations
  class ProcessOperation

    extend LightService::Action
    expects :remote_operation, :ledger_sequence

    executed do |c|
      remote_operation = c.remote_operation
      external_id = remote_operation[:id]

      operation = Operation.find_by(external_id: external_id)

      next if operation.present?

      operation = Operation.create!({
        external_id: external_id,
        ledger_sequence: c.ledger_sequence,
        body: remote_operation.to_hash,
      })

      EnqueueProcessWardOperationJobs.(operation)
    end

  end
end
