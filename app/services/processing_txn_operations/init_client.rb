module ProcessingTxnOperations
  class InitClient

    extend LightService::Action
    expects :txn
    promises :client

    executed do |c|
      c.client = Hyperclient.new(uri(c.txn.external_id)) do |c|
        c.options[:async] = false
      end
    end

    def self.uri(external_id)
      uri = URI(ENV["HORIZON_URL"])
      uri.path = "/transactions/#{external_id}/operations"
      uri.to_s
    end

  end
end
