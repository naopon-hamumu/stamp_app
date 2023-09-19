source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.4'

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem 'rails', '~> 7.0.6'

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
# gem "sprockets-rails", "~> 3.4"
gem 'sprockets-rails', require: 'sprockets/railtie'

# Use postgresql as the database for Active Record
gem 'pg', '~> 1.1'

# Use the Puma web server [https://github.com/puma/puma]
gem 'puma', '~> 5.0'

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem 'importmap-rails'

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem 'turbo-rails', '~> 1.1'

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem 'stimulus-rails', '~> 1.0'

# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem 'jbuilder', '~> 2.11'

# Use Redis adapter to run Action Cable in production
# gem "redis", "~> 4.0"

# Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# gem "kredis"

# Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'bcrypt', '~> 3.1.7'
gem 'devise'

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '1.12', require: false

# Use Sass to process CSS
gem 'sassc-rails'

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# gem "image_processing", "~> 1.2"

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'bullet'
  gem 'rubocop', require: false
  gem 'faker'
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem 'web-console', '4.2'

  # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
  # gem "rack-mini-profiler"

  # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
  # gem "spring"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'capybara', '3.37.1'
  gem 'guard', '2.18.0'
  gem 'guard-minitest', '2.4.6'
  gem 'minitest', '5.15.0'
  gem 'minitest-reporters', '1.5.0'
  gem 'rails-controller-testing', '1.0.5'
  gem 'selenium-webdriver', '4.2.0'
  gem 'webdrivers', '5.0.0'
end

gem 'rails-i18n', '~> 7.0'

# Bootstrap
gem 'bootstrap', '~> 5.3'
gem 'jquery-rails'
gem 'popper_js', '~> 2.11.8'

# omniauth
gem 'dotenv-rails'
gem 'omniauth-google-oauth2'
gem 'omniauth-rails_csrf_protection'

# image_upload
gem 'carrierwave'
gem 'image_processing'
gem 'mini_magick'

# Google Map
gem 'geocoder'
gem 'gmaps4rails'

# related_db_save
gem 'rondo_form', '~> 0.2.3'

# enum
gem 'enum_help'

# search
gem 'coffee-rails'
gem 'ransack'

# admin
gem 'trestle'
gem 'trestle-auth'

# page_nation
gem 'kaminari'
gem 'bootstrap5-kaminari-views'
