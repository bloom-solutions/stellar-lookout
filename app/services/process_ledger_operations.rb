class ProcessLedgerOperations

  def self.call(ledger_sequence)
    with(ledger_sequence: ledger_sequence).reduce(
      ProcessingLedgerOperations::InitClient,
      ProcessingLedgerOperations::CreateOperations,
    )
  end

end
