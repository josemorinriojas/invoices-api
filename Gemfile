source "https://rubygems.org"

gem "rails", "~> 8.0.2"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]

gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

gem "bootsnap", require: false
gem "kamal", require: false

gem "thruster", require: false
gem 'active_model_serializers', '~> 0.10.0'
gem 'redis'
gem 'sidekiq'
gem 'sidekiq-scheduler', '>= 4.0.0'
gem 'rack-cors'
gem 'kaminari'

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'
  gem "brakeman", require: false
  gem "rubocop-rails-omakase", require: false

  gem 'dotenv-rails'
  gem 'pry'
end
