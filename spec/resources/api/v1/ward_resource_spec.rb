require 'rails_helper'

module Api
  module V1
    RSpec.describe WardResource, type: :resource do

      let(:ward) { build_stubbed(:ward) }
      subject { described_class.new(ward, {}) }

      it { is_expected.to have_attribute(:address) }
      it { is_expected.to have_attribute(:callback_url) }
      it { is_expected.to have_attribute(:secret) }

    end
  end
end
