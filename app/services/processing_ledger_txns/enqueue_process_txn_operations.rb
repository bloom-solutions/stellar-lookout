module ProcessingLedgerTxns
  class EnqueueProcessTxnOperations

    def self.call(txn)
      return if txn.operation_count <= txn.operations.count
      ProcessTxnOperationsJob.perform_later(txn)
    end

  end
end
