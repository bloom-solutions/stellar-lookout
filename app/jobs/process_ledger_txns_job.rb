class ProcessLedgerTxnsJob < ApplicationJob

  def perform(ledger_sequence)
    ProcessLedgerTxns.(ledger_sequence)
  end

end
