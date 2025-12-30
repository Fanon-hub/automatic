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
gem 'jsbundling-rails'         # For JS bundling (esbuild, rollup, webpack, bun)
gem 'cssbundling-rails'        # For CSS processing (Tailwind, Sass, PostCSS, Bootstrap, etc.)

# Turbolinks (still works, but consider migrating to Turbo if possible)
gem 'turbolinks', '~> 5.2'

# JSON builder
gem 'jbuilder', '~> 2.7'

gem 'kaminari'

# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.20'

# Use Active Storage variants [optional]
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching
gem 'bootsnap', '>= 1.4.2', require: false

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
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

# Windows compatibility
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]