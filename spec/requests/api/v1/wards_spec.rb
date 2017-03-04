require 'rails_helper'

RSpec.describe "/api/v1/wards" do

  it "creates a ward" do
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

    expect(response).to be_success

    response_body = JSON.parse(response.body)
    data = response_body["data"]

    attributes = data["attributes"]
    expect(attributes["address"]).to eq "stellar-address"
    expect(attributes["callback-url"]).to eq "https://mysite.com/cb1"
    expect(attributes["secret"]).to eq "mysecret"
  end

end
