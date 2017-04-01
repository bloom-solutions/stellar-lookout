class SendReport

  extend LightService::Organizer

  def self.call(report)
    return if report.complete?

    ctx = with(report: report).reduce(
      SendingReport::PostOperationBody,
      SendingReport::ProcessResponse,
    )

    if ctx.failure?
      report.report_responses.create(body: ctx.message)
    end

    ctx
  end

end
