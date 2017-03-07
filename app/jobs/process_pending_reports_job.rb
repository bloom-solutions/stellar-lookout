class ProcessPendingReportsJob < ActiveJob::Base

  def perform
    Report.pending.find_each do |report|
      enqueue(report)
    end
  end

  private

  def enqueue(report)
    return false if Time.now < next_run_time(report)
    SendReportJob.perform_later(report)
  end

  def next_run_time(report)
    report.created_at + Fibonacci.(report.report_responses.count).seconds
  end

end
