class ProcessLedger

  extend LightService::Organizer

  def self.call(sequence)
    with(ledger_sequence: sequence).reduce(
      ProcessingLedger::InitClient,
      ProcessingLedger::FindLedger,
      ProcessingLedger::UpdateLedger,
      ProcessingLedger::EnqueueProcessLedgerOperations,
    )
  end

end
