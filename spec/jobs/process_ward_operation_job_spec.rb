require 'rails_helper'

RSpec.describe ProcessWardOperationJob do

  let(:ward) { build_stubbed(:ward) }
  let(:operation) { build_stubbed(:operation) }

  it "delegates work to ProcessWardOperation" do
    expect(ProcessWardOperation).to receive(:call).
      with(ward, operation)

    described_class.new.perform(ward, operation)
  end

end
