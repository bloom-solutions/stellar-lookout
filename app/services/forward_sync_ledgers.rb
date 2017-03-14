class ForwardSyncLedgers

  extend LightService::Organizer

  def self.call
    reduce(
      ForwardSyncing::GetLatestSequence,
      GetPagingToken,
      EnqueueProcessLedgers,
    )
  end

end
