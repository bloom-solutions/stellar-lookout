module Api
  module V1
    class WardResource < JSONAPI::Resource

      after_create :enqueue_after_create_job

      attributes *%i[address callback_url secret]

      private

      def enqueue_after_create_job
        ActiveRecord::Base.after_transaction do
          WardAfterCreateJob.perform_later(@model)
        end
      end

    end
  end
end
