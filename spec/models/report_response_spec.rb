require 'rails_helper'

RSpec.describe ReportResponse do

  describe "associations" do
    it { is_expected.to belong_to :report }
  end

end
