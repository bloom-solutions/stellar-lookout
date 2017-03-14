class BackwardSyncLedgersJob < ApplicationJob

  def perform
    BackwardSyncLedgers.()
  end

end
