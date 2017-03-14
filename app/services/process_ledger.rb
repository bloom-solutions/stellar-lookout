class ProcessLedger

  extend LightService::Organizer

  def self.call(remote_ledger_hash)
    with(remote_ledger_hash: remote_ledger_hash).reduce(
      ProcessingLedger::CreateOrUpdateLedger,
      ProcessingLedger::EnqueueProcessLedgerTxns,
    )
  end

end
