require 'rails_helper'

RSpec.describe ProcessPendingReportsJob do

  let!(:report_1) { create(:report, status: "pending") }
  let!(:report_2) { create(:report, status: "complete") }

  it "attempts to re-send reports that failed to send" do
    described_class.new.perform

    expect(SendReportJob).to have_been_enqueued.with(report_1)
  end

end
