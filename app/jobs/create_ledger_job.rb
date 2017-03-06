class CreateLedgerJob < ActiveJob::Base

  def perform(sequence)
    ledger = Ledger.where(sequence: sequence).first_or_create!
    ProcessLedgerJob.perform_later(sequence)
  end

end
