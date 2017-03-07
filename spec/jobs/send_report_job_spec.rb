require 'rails_helper'

RSpec.describe SendReportJob do

  let(:report) { build_stubbed(:report) }

  it "delegates work to SendReport" do
    expect(SendReport).to receive(:call).with(report)
    described_class.new.perform(report)
  end

end
