require 'rails_helper'

RSpec.describe "/api/v1/wards" do

  context "ward does not exist" do
    it "ward does not exist", cleaning_strategy: :truncation do
      jsonapi_post("/api/v1/wards", {
        params: {
          data: {
            type: "wards",
            attributes: {
              "address" => "stellar-address",
            },
          }
        }
      })

      expect(response).to be_successful

      response_body = JSON.parse(response.body)
      data = response_body["data"]

      attributes = data["attributes"]
      expect(attributes["address"]).to eq "stellar-address"
    end
  end

  context "ward already exists" do
    let!(:ward) { create(:ward, address: "stellar-address") }

    it "behaves as if the ward did not exist" do
      # Create the same one again
      jsonapi_post("/api/v1/wards", {
        params: {
          data: {
            type: "wards",
            attributes: {
              "address" => "stellar-address",
            },
          }
        }
      })

      expect(response).to be_successful

      response_body = JSON.parse(response.body)
      data = response_body["data"]

      attributes = data["attributes"]
      expect(attributes["address"]).to eq "stellar-address"

      wards = Ward.where(address: "stellar-address")
      expect(wards.count).to eq 1
      expect(WardAfterCreateJob).to_not have_been_enqueued
    end
  end

end
