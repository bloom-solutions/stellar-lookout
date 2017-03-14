class GetPagingToken

  extend LightService::Action
  expects :sequence
  promises :paging_token

  executed do |c|
    c.paging_token = of_sequence(c.sequence)
  end

  def self.of_sequence(sequence)
    if ledger = Ledger.find_by(sequence: sequence)
      ledger.paging_token
    else
      client(sequence).paging_token
    end
  end

  private

  def self.client(sequence)
    Hyperclient.new(uri(sequence)) do |config|
      config.options[:async] = false
    end
  end

  def self.uri(sequence)
    uri = URI(ENV["HORIZON_URL"])
    uri.path = "/ledgers/#{sequence}"
    uri.to_s
  end

end
