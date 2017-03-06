class SendReport

  extend LightService::Organizer

  def self.call(report)
    return if report.complete?

    with(report: report).reduce(
      SendingReport::PostOperationBody,
      SendingReport::ProcessResponse,
    )
  end

end
