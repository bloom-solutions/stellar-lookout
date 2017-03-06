require 'rails_helper'

module ProcessingLedgerOperations
  RSpec.describe EnqueueProcessWardOperationJobs do

    let(:ward_1) { create(:ward) }
    let(:ward_2) { create(:ward) }
    let(:wards) { [ ward_1, ward_2 ] }
    let(:operation) { create(:operation) }

    it "enqueues a ProcessingWardOperationJob per interested ward" do
      expect(Ward).to receive(:watching).with(operation).and_return(wards)

      described_class.(operation)

      wards.each do |ward|
        expect(ProcessWardOperationJob).to have_been_enqueued.
          with(ward, operation)
      end
    end

  end
end
