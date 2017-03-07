require 'rails_helper'

module SendingReport
  RSpec.describe ProcessResponse do
    
    context "unsuccessful response" do
      let(:report) { build_stubbed(:report) }
      let(:response) do
        instance_double(Faraday::Response, {
          status: 400,
          body: {some: "response"},
        })
      end

      it "creates a report response and marks the report as completed" do
        expect(ReportResponse).to receive(:create!).with(
          report_id: report.id,
          status: 400,
          body: {some: "response"},
        )

        expect(report).to_not receive(:complete!)

        described_class.execute(report: report, response: response)
      end
    end

    context "successful response" do
      let(:report) { build_stubbed(:report) }
      let(:response) do
        instance_double(Faraday::Response, {
          status: 200,
          body: {some: "response"},
        })
      end

      it "creates a report response and marks the report as completed" do
        expect(ReportResponse).to receive(:create!).with(
          report_id: report.id,
          status: 200,
          body: {some: "response"},
        )

        expect(report).to receive(:complete!)

        described_class.execute(report: report, response: response)
      end
    end

  end
end
