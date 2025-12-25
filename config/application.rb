require "logger"
require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module CdpWebManyoTask
  class Application < Rails::Application
    config.load_defaults 6.1
    # config.load_defaults 6.1  
    
    config.i18n.available_locales = [:en, :ja] 
    config.i18n.default_locale = :ja 
    config.time_zone = 'Tokyo'
    config.generators do |g|
      g.assets false
      g.helper false
      g.test_framework :rspec,
        model_specs: true,
        view_specs: false,
        controller_specs: false,
        routing_specs: false,
        helper_specs: false,
        request_specs: false
    end
  end
end
