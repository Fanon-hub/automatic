source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.3.0'

# Rails 7.2.0 (exact version as you specified)
gem 'rails', '7.2.0'

# Database
gem 'pg', '>= 0.18', '< 2.0'

# Web server
gem 'puma', '~> 6.4'  # Updated from 4.1 → modern secure version (Puma 4.x is EOL)

# Modern asset pipeline (replaces Sprockets/Webpacker)
gem 'propshaft'                # Handles fingerprinting & asset serving
 
# Turbolinks (still works, but consider migrating to Turbo if possible)
gem 'turbolinks', '~> 5.2'

gem 'turbo-rails'

# JSON builder
gem 'jbuilder', '~> 2.7'
gem 'importmap-rails'

gem 'kaminari'

# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.20'

# Use Active Storage variants [optional]
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'rspec-rails'
end

group :development do
  # Better errors & console
  gem 'web-console', '>= 4.2'
  gem 'listen', '~> 3.9'
  # Spring no longer needed in modern Rails (can remove)
  # gem 'spring'
  # gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # System testing
  gem 'capybara', '>= 3.39'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end

group :production do
  gem 'rails_12factor'
  gem 'sprockets-rails'
end

# Windows compatibility
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
