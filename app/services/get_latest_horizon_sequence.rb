class GetLatestHorizonSequence

  def self.call
    client = Hyperclient.new(ENV["HORIZON_URL"]) do |c|
      c.options[:async] = false
    end
    client.history_latest_ledger
  end

end
