module Api
  module V1
    class WardProcessor < JSONAPI::Processor

      def create_resource
        data = params[:data]
        record = resource_klass._model_class.
          find_by(data[:attributes].slice(:address, :callback_url))
        resource = record.present? ?  resource_klass.new(record, {}) : nil

        if resource.nil?
          resource = resource_klass.create(context)
          result = resource.replace_fields(data)
        end

        return JSONAPI::ResourceOperationResult.new((result == :completed ? :created : :accepted), resource, result_options)
      end

    end
  end
end
