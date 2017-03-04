module Helpers
  module Request
    module Capybara
      module JSONAPI

        HEADERS = {
          "Content-Type" => "application/vnd.api+json",
          "Accept" => "application/vnd.api+json",
        }

        def jsonapi_post(path, opts={})
          options = opts

          options[:headers] ||= {}
          options[:headers].merge!(HEADERS)

          if options[:params].respond_to?(:to_json)
            options[:params] = options[:params].to_json
          end

          post(path, options)
        end

        def jsonapi_get(path, opts={})
          options = opts

          options[:headers] ||= {}
          options[:headers].merge!(HEADERS)

          if options[:params].respond_to?(:to_json)
            options[:params] = options[:params].to_json
          end

          get(path, options)
        end

      end
    end
  end
end

RSpec.configuration.include Helpers::Request::Capybara::JSONAPI, type: :request
