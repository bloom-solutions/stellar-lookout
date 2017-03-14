class ProcessTxnOperations

  extend LightService::Organizer

  def self.call(txn)
    with(txn: txn).reduce(
      ProcessingTxnOperations::InitClient,
      ProcessingTxnOperations::CreateOperations,
    )
  end

end
