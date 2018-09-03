require 'rails_helper'

module Api
  module V1
    RSpec.describe WardResource, type: :resource do

      let(:ward) { build_stubbed(:ward) }
      subject { described_class.new(ward, {}) }

      it { is_expected.to have_attribute(:address) }

    end
  end
end
