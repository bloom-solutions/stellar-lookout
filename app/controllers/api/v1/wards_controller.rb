module Api
  module V1
    class WardsController < BaseController

      api :POST, "/v1/wards"
      formats %w(json)
      header "Content-Type", "application/vnd.api+json", required: true
      header "Accept", "application/vnd.api+json", required: true
      param :data, Hash do
        param :type, %w(wards), required: true
        param :attributes, Hash, required: true do
          param(:address, String, {
            desc: "Stellar account id / address that you want to watch",
            required: true,
          })
          param("callback-url", String, {
            desc: "Where you are notified of activity",
            required: true,
          })
          param(:secret, String, {
            desc: "A secret used to sign the body posted back to you",
          })
        end
      end
      description <<-STR
      Create wards that watch Stellar addresses. When there is an operation that your ward is interested in, the `callback-url` specified will receive a POST. What is posted is exactly what horizon generates for the operation. See examples.

      ### Retry
      If the callback server responds with a non-success HTTP status, StellarLookout will keep retrying to send for about 28 days.
      STR
      example <<-STR
      # Create a ward
      Headers:
        - Content-Type: application/vnd.api+json
        - Accept: application/vnd.api+json

      Body:
        {
          "data": {
            "type": "wards",
            "attributes": {
              "address": "stellar-address",
              "callback-url": "https://mysite.com/cb1",
              "secret": "mysecret"
            }
          }
        }

      # Callback
      Headers:
        - Authorization: HMAC-SHA256 681ab1a0c545ff9c6529e63abd64823355dee3d53ea9219ef59ee31ff724c217

      Body:
        {
          "_links": {
            "self": {
              "href": "https://horizon-testnet.stellar.org/operations/584115556353"
            },
            "transaction": {
              "href": "https://horizon-testnet.stellar.org/transactions/029a5ebad978edb3b7ef8f70dd36c57997e188850985d59465805e950e84ebdc"
            },
            "effects": {
              "href": "https://horizon-testnet.stellar.org/operations/584115556353/effects"
            },
            "succeeds": {
              "href": "https://horizon-testnet.stellar.org/effects?order=desc\u0026cursor=584115556353"
            },
            "precedes": {
              "href": "https://horizon-testnet.stellar.org/effects?order=asc\u0026cursor=584115556353"
            }
          },
          "id": "584115556353",
          "paging_token": "584115556353",
          "source_account": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H",
          "type": "create_account",
          "type_i": 0,
          "starting_balance": "50000000.0000000",
          "funder": "GBRPYHIL2CI3FNQ4BXLFMNDLFJUNPU2HY3ZMFSHONUCEOASW7QC7OX2H",
          "account": "GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K"
        }
      STR
      def create
        super
      end

    end
  end
end
