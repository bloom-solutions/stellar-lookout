require 'rails_helper'

RSpec.describe Report do

  describe "assocations" do
    it { is_expected.to belong_to(:operation) }
    it { is_expected.to belong_to(:ward) }
    it { is_expected.to have_many(:report_responses) }
  end

end
