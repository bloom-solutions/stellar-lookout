Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      jsonapi_resources :wards, only: %i[create]
    end
  end
end
