module ProcessingLedger
  class EnqueueProcessLedgerTxns

    extend LightService::Action
    expects :ledger

    executed do |c|
      ledger = c.ledger

      next if ledger.transaction_count <= ledger.txns.count
      ProcessLedgerTxnsJob.perform_later(ledger.sequence)
    end

  end
end
