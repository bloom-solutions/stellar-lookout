module ProcessingLedgerTxns
  class InitClient

    extend LightService::Action
    expects :ledger_sequence
    promises :client

    executed do |c|
      c.client = Hyperclient.new(uri(c.ledger_sequence)) do |c|
        c.options[:async] = false
      end
    end

    def self.uri(sequence)
      uri = URI(ENV["HORIZON_URL"])
      uri.path = "/ledgers/#{sequence}/transactions"
      uri.to_s
    end

  end
end
