module SendingReport
  class PostOperationBody

    extend LightService::Action
    expects :report
    promises :response

    executed do |c|
      report = c.report
      ward = report.ward

      client = Faraday.new(url: ward.callback_url) do |f|
        f.adapter Faraday.default_adapter
        f.response :detailed_logger, Rails.logger
      end

      begin
        c.response = post(client, ward, body_from(report.operation))
      rescue Faraday::Error => e
        c.fail!([e.class, e.message].join(" - "))
      end
    end

    private

    def self.post(client, ward, body)
      signature = hmac_signature_for(body, ward.secret)

      client.post do |request|
        request.url ward.callback_url
        request.body = { body: body.to_json }.to_json
        request.headers.merge!({
          "Authorization" => "HMAC-SHA256 #{signature}",
          "Content-Type" => "application/json",
        })
      end
    end

    def self.body_from(operation)
      {
        operation: operation.body,
        transaction: operation.txn.body,
      }
    end

    def self.hmac_signature_for(body, secret)
      json = body.respond_to?(:to_json) ? body.to_json : body
      OpenSSL::HMAC.hexdigest("SHA256", secret, json)
    end

  end
end
