require 'sidekiq/web'
require 'sidekiq/cron/web'

Rails.application.routes.draw do

  apipie
  namespace :api do
    namespace :v1 do
      jsonapi_resources :wards, only: %i[create]
    end
  end

  sidekiq_username = ENV.fetch("SIDEKIQ_USERNAME") { nil }
  sidekiq_password = ENV.fetch("SIDEKIQ_PASSWORD") { nil }

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    given_username_hash = ::Digest::SHA256.hexdigest(username)
    username_hash = ::Digest::SHA256.hexdigest(sidekiq_username)
    given_password_hash = ::Digest::SHA256.hexdigest(password)
    password_hash = ::Digest::SHA256.hexdigest(sidekiq_password)

    username_comparison = ActiveSupport::SecurityUtils.
      secure_compare(given_username_hash, username_hash)
    password_comparison = ActiveSupport::SecurityUtils.
      secure_compare(given_password_hash, password_hash)

    username_comparison & password_comparison
  end if Rails.env.production?

  if sidekiq_username.present? && sidekiq_password.present? ||
      !Rails.env.production?
    mount Sidekiq::Web => '/sidekiq'
  end

end
