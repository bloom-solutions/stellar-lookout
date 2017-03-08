module SendingReport
  class PostOperationBody

    extend LightService::Action
    expects :report
    promises :response

    executed do |c|
      report = c.report
      operation = report.operation
      ward = report.ward

      signature = hmac_signature_for(operation.body, ward.secret)

      client = Faraday.new(url: ward.callback_url) do |f|
        f.adapter Faraday.default_adapter
        f.response :detailed_logger, Rails.logger
      end

      c.response = client.post do |request|
        request.url ward.callback_url
        request.body = operation.body.to_json
        request.headers["Authorization"] = "HMAC-SHA256 #{signature}"
      end
    end

    def self.hmac_signature_for(body, secret)
      json = body.respond_to?(:to_json) ? body.to_json : body
      OpenSSL::HMAC.hexdigest("SHA256", secret, json)
    end

  end
end
