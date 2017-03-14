class ForwardSyncLedgersJob < ApplicationJob

  def perform
    ForwardSyncLedgers.()
  end

end
