require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do
  apipie
  namespace :api do
    namespace :v1 do
      jsonapi_resources :wards, only: %i[create]
    end
  end

  mount Sidekiq::Web => '/sidekiq'
end
