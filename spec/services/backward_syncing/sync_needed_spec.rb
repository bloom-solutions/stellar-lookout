require 'rails_helper'

module BackwardSyncing
  RSpec.describe SyncNeeded do

    describe ".execute" do
      subject(:resulting_ctx) { described_class.execute }

      context "sync needed" do
        it "doesn't skip" do
          expect(described_class).to receive(:call).and_return(true)
          expect(resulting_ctx).to_not be_skip_all
        end
      end

      context "sync not needed" do
        it "skips" do
          expect(described_class).to receive(:call).and_return(false)
          expect(resulting_ctx).to be_skip_all
        end
      end
    end

    describe ".call" do
      subject { described_class.() }

      context "there is no space to sync back" do
        before do
          Timecop.travel 1.minute.ago
          create(:ledger, sequence: 10)
          Timecop.return
          create(:ledger, sequence: 9)
        end
        it { is_expected.to be false }
      end

      context "there is space to sync back" do
        before do
          Timecop.travel 1.minute.ago
          create(:ledger, sequence: 10)
          Timecop.return
          create(:ledger, sequence: 8)
        end
        it { is_expected.to be true }
      end
    end

  end
end
