module ProcessingTxnOperations
  class EnqueueProcessWardOperationJobs

    def self.call(operation)
      Ward.watching(operation).each do |ward|
        ProcessWardOperationJob.perform_later(ward, operation)
      end
    end

  end
end
