class ProcessLedgersJob

  include Sidekiq::Worker
  sidekiq_options retry: false
  BATCH_SIZE = 5

  def perform(batch_size=5)
    latest_ledger = Ledger.order(sequence: :desc).first

    from_sequence = latest_ledger.present? ? latest_ledger.sequence : 1
    to_sequence = from_sequence + batch_size

    horizon_latest_ledger_sequence = client.history_latest_ledger
    if to_sequence > horizon_latest_ledger_sequence
      to_sequence = horizon_latest_ledger_sequence
    end

    (from_sequence..to_sequence).each do |n|
      CreateLedgerJob.perform_later(n)
    end
  end

  private

  def client
    Hyperclient.new(ENV["HORIZON_URL"]) do |c|
      c.options[:async] = false
    end
  end

end
