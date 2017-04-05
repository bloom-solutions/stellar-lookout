class ProcessWardOperation

  def self.call(ward, operation)
    report = Report.where(ward_id: ward.id, operation_id: operation.id).
      first_or_initialize

    return if report.persisted?

    report.save!

    ActiveRecord::Base.after_transaction do
      SendReportJob.perform_later(report)
    end
  end

end
