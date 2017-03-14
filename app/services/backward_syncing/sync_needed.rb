module BackwardSyncing
  class SyncNeeded

    extend LightService::Action

    executed do |c|
      c.skip_all! if !self.call
    end

    def self.call
      earliest_created_ledger = Ledger.order(created_at: :asc).first
      !Ledger.exists?(sequence: earliest_created_ledger.sequence-1)
    end

  end
end
