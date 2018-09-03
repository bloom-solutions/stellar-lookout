require 'rails_helper'

RSpec.describe "/api/v1/wards" do

  it "creates a ward if it does not exist", cleaning_strategy: :truncation do
    jsonapi_post("/api/v1/wards", {
      params: {
        data: {
          type: "wards",
          attributes: {
            "address" => "stellar-address",
            "callback-url" => "https://mysite.com/cb1",
            "secret" => "mysecret",
          },
        }
      }
    })

    expect(response).to be_successful

    response_body = JSON.parse(response.body)
    data = response_body["data"]

    attributes = data["attributes"]
    expect(attributes["address"]).to eq "stellar-address"
    expect(attributes["callback-url"]).to eq "https://mysite.com/cb1"
    expect(attributes["secret"]).to eq "mysecret"

    # Create the same one again
    jsonapi_post("/api/v1/wards", {
      params: {
        data: {
          type: "wards",
          attributes: {
            "address" => "stellar-address",
            "callback-url" => "https://mysite.com/cb1",
            "secret" => "mysecret",
          },
        }
      }
    })

    expect(response).to be_successful

    response_body = JSON.parse(response.body)
    data = response_body["data"]

    attributes = data["attributes"]
    expect(attributes["address"]).to eq "stellar-address"
    expect(attributes["callback-url"]).to eq "https://mysite.com/cb1"

    expect(response)
    wards = Ward.where({
      address: "stellar-address",
      callback_url: "https://mysite.com/cb1",
    })
    expect(wards.count).to eq 1

    expect(WardAfterCreateJob).to have_been_enqueued.with(wards.first)

    # Create another with a different callback url
    jsonapi_post("/api/v1/wards", {
      params: {
        data: {
          type: "wards",
          attributes: {
            "address" => "stellar-address",
            "callback-url" => "https://mysite.com/cb2",
            "secret" => "mysecret",
          },
        }
      }
    })

    expect(response).to be_successful

    response_body = JSON.parse(response.body)
    data = response_body["data"]

    attributes = data["attributes"]
    expect(attributes["address"]).to eq "stellar-address"
    expect(attributes["callback-url"]).to eq "https://mysite.com/cb2"

    wards = Ward.where(address: "stellar-address")
    expect(wards.count).to eq 2

    expect(WardAfterCreateJob).to have_been_enqueued.with(wards.last)
  end

end
