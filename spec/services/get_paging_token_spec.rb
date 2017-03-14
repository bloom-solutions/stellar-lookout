require 'rails_helper'

RSpec.describe GetPagingToken do

  describe ".of_sequence" do
    subject { described_class.of_sequence(sequence) }

    context "there is no local ledger", vcr: {record: :once} do
      let(:sequence) { 9578569 }
      let(:paging_token) { "41139640597479424" }
      it { is_expected.to eq paging_token }
    end

    context "there is a local ledger" do
      let(:sequence) { 33 }
      let(:paging_token) { "fake411" }
      let!(:ledger) do
        create(:ledger, sequence: sequence, paging_token: paging_token)
      end
      it { is_expected.to eq paging_token }
    end

    context "given a nil sequence" do
      let(:sequence) { nil }
      it { is_expected.to be_nil }
    end
  end

  describe ".execute" do
    it "places the paging token in the context" do
      expect(described_class).to receive(:of_sequence).with(9578569).
        and_return("41139640597479424")

      resulting_ctx = described_class.execute(sequence: 9578569)

      expect(resulting_ctx.paging_token).to eq "41139640597479424"
    end
  end

end
