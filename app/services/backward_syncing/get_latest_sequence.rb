module BackwardSyncing
  class GetLatestSequence

    extend LightService::Action
    promises :sequence

    executed do |c|
      earliest_local_ledger = Ledger.order(created_at: :asc).first

      if earliest_local_ledger.nil?
        c.sequence = nil
        next c
      end

      ledger = Ledger.order(sequence: :asc).
        sequence_before(earliest_local_ledger.sequence).last

      if ledger.nil?
        c.sequence = nil
        next c
      end

      c.sequence = ledger.sequence
    end

  end
end
