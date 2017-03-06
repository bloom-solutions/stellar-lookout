class ProcessLedgersJob

  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(history_latest_ledger=nil)
    # NOTE: Accept history_latest_ledger arg for testing purposes.
    # On prod, you would not want to pass in what the latest ledger
    # sequence on Horizon is.
    history_latest_ledger ||= client.history_latest_ledger

    latest_ledger = Ledger.order(sequence: :desc).first

    (latest_ledger.sequence..history_latest_ledger).each do |n|
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
