require 'rails_helper'

RSpec.describe ProcessPendingReportsJob do

  it "attempts to re-send reports that failed to send" do
    Timecop.freeze

    report_1 = create(:report, status: "pending")
    report_2 = create(:report, status: "complete")
    report_3 = create(:report, status: "pending")
    create(:report_response, report: report_3)
    create(:report_response, report: report_3)
    create(:report_response, report: report_3)
    create(:report_response, report: report_3)
    create(:report_response, report: report_3)


    described_class.new.perform

    expect(SendReportJob).to have_been_enqueued.with(report_1)
    report_1.complete!

    Timecop.travel 6.seconds.from_now
    described_class.new.perform
    expect(SendReportJob).to have_been_enqueued.with(report_3)
  end

end
