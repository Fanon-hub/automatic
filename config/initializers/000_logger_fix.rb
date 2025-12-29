require 'logger' unless defined?(Logger)


module ActiveSupport
  module LoggerThreadSafeLevel
    # Ensure Logger::Severity is available
    unless defined?(::Logger::Severity)
      require 'logger'
    end
  end
end