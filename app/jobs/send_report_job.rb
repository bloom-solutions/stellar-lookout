class SendReportJob < ActiveJob::Base

  def perform(report)
    SendReport.(report)
  end

end
