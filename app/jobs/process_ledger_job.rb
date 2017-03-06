class ProcessLedgerJob < ActiveJob::Base

  def perform(ledger_sequence)
    ProcessLedger.(ledger_sequence)
  end

end
