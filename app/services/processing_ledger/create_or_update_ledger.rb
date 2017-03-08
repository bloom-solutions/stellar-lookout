module ProcessingLedger
  class CreateOrUpdateLedger

    extend LightService::Action
    expects :remote_ledger_hash
    promises :ledger

    executed do |c|
      remote_ledger_hash = c.remote_ledger_hash
      c.ledger = Ledger.where(sequence: remote_ledger_hash["sequence"]).
        first_or_initialize
      c.ledger.update_attributes!(
        external_id: remote_ledger_hash['id'],
        body: remote_ledger_hash,
      )
    end

  end
end
