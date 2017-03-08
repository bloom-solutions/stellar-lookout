module ProcessingLedgers
  class EnqueueNextBatch

    BATCH_SIZE = 2

    def self.call(batch_step, remote_ledgers)
      next_batch_step = batch_step + 1
      if next_batch_step < BATCH_SIZE && remote_ledgers.any?
        ProcessLedgersJob.perform_later(
          next_batch_step,
          remote_ledgers.last["sequence"]
        )
      end
    end

  end
end
