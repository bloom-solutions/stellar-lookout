module ProcessingLedgerTxns
  class ProcessTxn

    extend LightService::Action
    expects :remote_txn, :ledger_sequence

    executed do |c|
      remote_txn = c.remote_txn
      external_id = remote_txn[:id]

      txn = Txn.find_by(external_id: external_id)

      next if txn.present?

      txn = Txn.create!({
        external_id: external_id,
        ledger_sequence: c.ledger_sequence,
        body: remote_txn.to_hash,
      })

      EnqueueProcessTxnOperations.(txn)
    end

  end
end
