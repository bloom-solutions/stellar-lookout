require 'rails_helper'

module SendingReport
  RSpec.describe PostOperationBody do

    let(:operation) { build_stubbed(:operation, body: {jay: "son"}.to_json) }
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
      OpenSSL::HMAC.hexdigest("SHA256", ward.secret, operation.body)
    end

    it "posts to the operation's body with the correct hmac signature" do
      stub_request(:post, "https://cb.com").with(
        body: operation.body,
        headers: {"Authorization" => "HMAC-SHA256 #{expected_hmac_signature}"},
      ).to_return(body: {"ok" => "body"}.to_json)

      resulting_ctx = described_class.execute(report: report)

      expect(resulting_ctx.response.body).to be_present
    end

  end
end
