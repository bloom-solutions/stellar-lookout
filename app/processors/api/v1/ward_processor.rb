module Api
  module V1
    class WardProcessor < JSONAPI::Processor

      def create_resource
        data = params[:data]
        matching_resources = resource_klass.find(
          {},
          data[:attributes].slice(:address, :callback_url),
        )
        resource = matching_resources.first

        if resource.nil?
          resource = resource_klass.create(context)
          result = resource.replace_fields(data)
        end

        return JSONAPI::ResourceOperationResult.new((result == :completed ? :created : :accepted), resource, result_options)
      end

    end
  end
end
