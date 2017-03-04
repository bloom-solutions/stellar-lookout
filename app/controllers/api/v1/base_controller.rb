module Api
  module V1
    class BaseController < Api::BaseController

      include JSONAPI::ActsAsResourceController

    end
  end
end
