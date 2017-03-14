class ProcessLedgersJob < ActiveJob::Base

  LIMIT = 100

  def perform(paging_token)
    remote_ledgers_from(paging_token).each do |record|
      process_remote_ledger(record)
    end
  end

  private

  def process_remote_ledger(remote_ledger)
    ProcessLedger.(remote_ledger.to_hash)
  end

  def remote_ledgers_from(paging_token)
    client(paging_token).records
  end

  def uri(paging_token)
    uri = URI(ENV["HORIZON_URL"])
    uri.path = "/ledgers"
    uri.query = URI.encode_www_form({
      order: "asc",
      limit: LIMIT,
      cursor: paging_token,
    })
    uri.to_s
  end

  def client(paging_token)
    Hyperclient.new(uri(paging_token)) do |c|
      c.options[:async] = false
    end
  end

end
