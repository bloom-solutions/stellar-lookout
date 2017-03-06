class ProcessPendingReportsJob < ActiveJob::Base

  def perform
    Report.pending.find_each do |report|
      SendReportJob.perform_later(report)
    end
  end

end
