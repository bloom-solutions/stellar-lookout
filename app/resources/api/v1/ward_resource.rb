module Api
  module V1
    class WardResource < JSONAPI::Resource

      attributes *%i[address callback_url secret]

    end
  end
end
