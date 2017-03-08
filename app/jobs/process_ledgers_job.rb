class ProcessLedgersJob < ActiveJob::Base

  BATCH_SIZE = 2
  LIMIT = 20

  def perform(batch_step=0, from_sequence=nil)
    from_cursor = cursor_of(from_sequence)
    remote_ledgers = remote_ledgers_from(from_cursor)
    remote_ledgers.each { |record| process_remote_ledger(record) }
    if batch_step+1 < BATCH_SIZE
      self.class.perform_later(batch_step+1, remote_ledgers.last["sequence"])
    end
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
    uri = URI("https://horizon.stellar.org")
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
