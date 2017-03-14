class ProcessLedgerTxns

  extend LightService::Organizer

  def self.call(ledger_sequence)
    with(ledger_sequence: ledger_sequence).reduce(
      ProcessingLedgerTxns::InitClient,
      ProcessingLedgerTxns::CreateTxns,
    )
  end

end
