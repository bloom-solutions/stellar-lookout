class BackwardSyncLedgers

  extend LightService::Organizer

  def self.call
    reduce(
      BackwardSyncing::SyncNeeded,
      BackwardSyncing::GetLatestSequence,
      GetPagingToken,
      EnqueueProcessLedgers,
    )
  end

end
