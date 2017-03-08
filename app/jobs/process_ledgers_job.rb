class ProcessLedgersJob < ActiveJob::Base

  LIMIT = 100

  def perform(batch_step=0, from_sequence=nil)
    from_cursor = cursor_of(from_sequence)
    remote_ledgers = remote_ledgers_from(from_cursor)
    remote_ledgers.each { |record| process_remote_ledger(record) }
    ProcessingLedgers::EnqueueNextBatch.(batch_step, remote_ledgers)
  end

  private

  def cursor_of(sequence)
    ledger = if sequence
               Ledger.find_by(sequence: sequence)
             else
               Ledger.order(sequence: :asc).last
             end
    ledger.present? ? ledger.paging_token : nil
  end

  def process_remote_ledger(remote_ledger)
    ProcessLedger.(remote_ledger.to_hash)
  end

  def remote_ledgers_from(cursor)
    client(cursor).records
  end

  def uri(cursor)
    uri = URI(ENV["HORIZON_URL"])
    uri.path = "/ledgers"
    uri.query = URI.encode_www_form(order: "asc", limit: LIMIT, cursor: cursor)
    uri.to_s
  end

  def client(cursor)
    Hyperclient.new(uri(cursor)) do |c|
      c.options[:async] = false
    end
  end

end
