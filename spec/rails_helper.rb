# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'
Rails.root.glob('spec/support/**/*.rb').sort.each { |f| require f }
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories.
# Rails.root.glob('spec/support/**/*.rb').sort.each { |f| require f }

# Checks for pending migrations and applies them before tests are run.
# If you are not using ActiveRecord, you can remove these lines.
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

RSpec.configure do |config|
  config.before(:each, type: :model) do 
    allow_any_instance_of(Task).to receive(:set_default_deadline_on) 
  end
  config.include FactoryBot::Syntax::Methods 
  
  config.include LoginHelpers, type: :system


  # config.before(.all) do
  #   FactoryBot.reload 
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  # config.fixture_paths = [Rails.root.join('spec/fixtures')]  # Modern plural version if needed

  # Use transactional fixtures (built-in to Rails & rspec-rails in modern versions)
  config.use_transactional_fixtures = true

  # You can uncomment this line to turn off ActiveRecord support entirely.
  # config.use_active_record = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location...
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!

  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
end