source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.3', '>= 6.0.3.2'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
# gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis'
gem 'redis-namespace'
gem 'redis-rails'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'json_web_token', '~> 0.3.5'
gem 'jwt'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
gem 'apollo_upload_server', '2.0.0.beta.1'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

# Graphql Gems
gem 'graphql', '1.8.13'
gem 'graphql-errors'
gem 'graphql-rails_logger'
gem 'graphql-batch'
gem 'graphiql-rails'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rails-erd'

  gem 'rubocop', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-shopify', require: false
  gem 'rubocop-faker', require: false
  gem 'rubocop-rspec', require: false

end

group :development do
  gem 'listen', '~> 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
gem 'simplecov', require: false, group: :test
