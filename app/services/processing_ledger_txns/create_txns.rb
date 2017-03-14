module ProcessingLedgerTxns
  class CreateTxns

    extend LightService::Action
    expects :client, :ledger_sequence

    executed do |c|
      each_txn(c.client._links.self) do |remote_txn|
        ProcessTxn.execute({
          remote_txn: remote_txn,
          ledger_sequence: c.ledger_sequence,
        })
      end
    end

    def self.each_txn(client, &block)
      client.records.each { |remote_txn| block.yield(remote_txn) }
      self.each_txn(client._links.next, &block) if client.records.any?
    end

  end
end
