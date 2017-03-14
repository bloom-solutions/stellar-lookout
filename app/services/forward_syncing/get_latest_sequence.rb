module ForwardSyncing
  class GetLatestSequence

    extend LightService::Action
    promises :sequence

    executed do |c|
      if ledger = Ledger.order(sequence: :asc).last
        c.sequence = ledger.sequence
      else
        c.sequence = GetLatestHorizonSequence.()
      end
    end

  end
end
