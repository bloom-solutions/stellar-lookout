require 'rails_helper'

RSpec.describe SendReportJob do

  let(:actions) do
    [
      SendingReport::PostOperationBody,
      SendingReport::ProcessResponse,
    ]
  end

  context "report is pending" do
    it "does nothing" do
      actions.each do |action|
        expect(action).to_not receive(:call)
      end

      described_class.(report)
    end
  end

end
