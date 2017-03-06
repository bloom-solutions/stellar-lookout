module ProcessingLedger
  class FindLedger

    extend LightService::Action
    expects :ledger_sequence
    promises :ledger

    executed do |c|
      c.ledger = Ledger.find_by!(sequence: c.ledger_sequence)
    end

  end
end
