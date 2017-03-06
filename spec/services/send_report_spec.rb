require 'rails_helper'

RSpec.describe SendReport do

  let(:actions) do
    [
      SendingReport::PostOperationBody,
      SendingReport::ProcessResponse,
    ]
  end

  context "report is complete" do
    let(:report) { build_stubbed(:report, status: "complete") }

    it "does nothing" do
      actions.each do |action|
        expect(action).to_not receive(:execute)
      end

      described_class.(report)
    end
  end

  context "report is pending" do
    let(:report) { build_stubbed(:report, status: "pending") }

    it "executes actions in order" do
      ctx = LightService::Context.new(report: report)

      actions.each do |action|
        expect(action).to receive(:execute).with(ctx).and_return(ctx)
      end

      described_class.(report)
    end
  end

end
