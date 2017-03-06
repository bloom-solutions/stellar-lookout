class ProcessWardOperationJob < ActiveJob::Base

  def perform(ward, operation)
    ProcessWardOperation.(ward, operation)
  end

end
