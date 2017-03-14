class ProcessTxnOperationsJob < ActiveJob::Base

  def perform(txn)
    ProcessTxnOperations.(txn)
  end

end
