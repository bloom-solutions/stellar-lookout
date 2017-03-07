class WardAfterCreateJob < ActiveJob::Base

  def perform(ward)
    Operation.watched_by(ward).find_each do |operation|
      ProcessWardOperationJob.perform_later(ward, operation)
    end
  end

end
