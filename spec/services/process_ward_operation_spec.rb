require 'rails_helper'

RSpec.describe ProcessWardOperation do

  let(:ward) { create(:ward) }
  let(:operation) { create(:operation) }

  context "a report exists for the ward-operation" do
    let!(:report) { create(:report, ward: ward, operation: operation) }

    it "does nothing" do
      described_class.(ward, operation)
      expect(SendReportJob).to_not have_been_enqueued
    end
  end

  context "a report does not exist for the ward-operation" do
    it "creates the report and enqueues a ReportJob" do
      described_class.(ward, operation)
      report = Report.find_by(ward_id: ward.id, operation_id: operation.id)
      expect(SendReportJob).to have_been_enqueued.with(report)
    end
  end

end
