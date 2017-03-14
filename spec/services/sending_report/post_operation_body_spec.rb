require 'rails_helper'

module SendingReport
  RSpec.describe PostOperationBody do

    let(:txn) { build_stubbed(:txn, body: {txn: "body"}) }
    let(:operation) do
      build_stubbed(:operation, txn: txn, body: {operation: "body"})
    end
    let(:ward) do
      build_stubbed(:ward, {
        secret: SecureRandom.uuid,
        callback_url: "https://cb.com",
      })
    end
    let(:report) do
      build_stubbed(:report, operation: operation, ward: ward)
    end
    let(:expected_hmac_signature) do
      OpenSSL::HMAC.hexdigest("SHA256", ward.secret, body.to_json)
    end
    let(:body) do
      {
        operation: operation.body,
        transaction: txn.body,
      }
    end

    it "posts to the operation's body with the correct hmac signature" do
      stub_request(:post, "https://cb.com").with(
        body: body.to_json,
        headers: {"Authorization" => "HMAC-SHA256 #{expected_hmac_signature}"},
      ).to_return(body: {"ok" => "body"}.to_json)

      resulting_ctx = described_class.execute(report: report)

      expect(resulting_ctx.response.body).to be_present
    end

  end
end
