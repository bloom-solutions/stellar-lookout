class ProcessLedgerOperationsJob < ActiveJob::Base

  def perform(ledger_sequence)
    ProcessLedgerOperations.(ledger_sequence)
  end

end
