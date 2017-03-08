Apipie.configure do |config|
  config.app_name                = "StellarLookout"
  config.api_base_url            = "/api"
  config.doc_base_url            = "/developers"
  config.markup = Apipie::Markup::Markdown.new
  config.validate = :explicitly
  # where is your API defined?
  config.api_controllers_matcher = "#{Rails.root}/app/controllers/**/*.rb"
end
