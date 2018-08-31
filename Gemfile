source 'https://rubygems.org'

ruby "2.5.1"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.0.2'
# Use sqlite3 as the database for Active Record
gem 'pg', "0.19.0"
# Use Puma as the app server
gem 'puma', '~> 3.0'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
gem "jsonapi-resources", "0.9.0"
gem "hyperclient", "0.8.2"
gem "light-service"

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 3.0'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
gem "sidekiq", "~> 5.2"
gem "sidekiq-cron", "0.4.4"
gem 'sidekiq-unique-jobs', "~> 6.0"
gem "faraday-detailed_logger", "~> 2.1"
gem "apipie-rails", "0.3.6"
gem "maruku", "0.7.2"
gem "lograge", "0.4.1"
gem "ar_after_transaction", "0.4.0"

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem "dotenv-rails", "~> 2.1"
  gem "pry-byebug"
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem "spring-commands-rspec"
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem "capybara", "~> 2.4"
  gem "rspec-rails", "~> 3.5"
  gem "jsonapi-resources-matchers", require: false
  gem "factory_girl_rails", "~> 4.8"
  gem "shoulda-matchers", "~> 3.1"
  gem "timecop", "0.8.0"
  gem "vcr", "~> 3.0"
  gem "webmock", "~> 2.3"
  gem "database_cleaner"
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
