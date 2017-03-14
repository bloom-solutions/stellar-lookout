module ProcessingTxnOperations
  class ProcessOperation

    extend LightService::Action
    expects :remote_operation, :txn

    executed do |c|
      remote_operation = c.remote_operation
      external_id = remote_operation[:id]

      operation = Operation.find_by(external_id: external_id)

      next if operation.present?

      operation = Operation.create!({
        external_id: external_id,
        txn_external_id: c.txn.external_id,
        body: remote_operation.to_hash,
      })

      EnqueueProcessWardOperationJobs.(operation)
    end

  end
end
