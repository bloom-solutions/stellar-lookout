module SendingReport
  class ProcessResponse

    extend LightService::Action
    expects :report, :response

    executed do |c|
      response = c.response
      report = c.report

      ReportResponse.create!(
        report_id: report.id,
        status: response.status,
        body: response.body,
      )

      next c if response.status < 200 || response.status >= 300

      report.complete!
    end

  end
end
