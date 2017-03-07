require 'rails_helper'

module Api
  module V1
    RSpec.describe WardResource, type: :resource do

      let(:ward) { build_stubbed(:ward) }
      subject { described_class.new(ward, {}) }

      it { is_expected.to have_attribute(:address) }
      it { is_expected.to have_attribute(:callback_url) }
      it { is_expected.to have_attribute(:secret) }

      describe "after_create" do
        let(:ward) { create(:ward) }
        let(:resource) { described_class.new(ward, {}) }

        it "enqueues WardAfterCreateJob" do
          # Don't know how to save a resource manually. Ugly hack it by
          # 1) ensuring the callback is there
          # 2) call the callback (`send`) and check that the Job was queued
          expect(resource._create_callbacks.map(&:filter)).
            to include(:enqueue_after_create_job)
          resource.send(:enqueue_after_create_job)
          expect(WardAfterCreateJob).to have_been_enqueued.with(ward)
        end
      end

    end
  end
end
