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
        end
      end
      description <<-STR
      Create wards that watch Stellar addresses. When there is an operation that your ward is interested in, the StellarLookout will publish the details in the MessageBus channel if your address (`/G-STELLAR-ADDRESS`).

      The JSON that is published is exactly what is seen in horizon. Published messages are kept for a set amount of time or set number of messages (this is configurable).
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
              "address": "GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K",
            }
          }
        }

      This will be published in the `/GBS43BF24ENNS3KPACUZVKK2VYPOZVBQO2CISGZ777RYGOPYC2FT6S3K` channel:
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
