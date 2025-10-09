# frozen_string_literal: true

require_relative 'error'

module DruidClient
  class DruidConfig
    DEFAULTS = {
      url: 'http://localhost:8888',
      user_agent: 'druid_client.rb',
      timeout: 30,
      verify_ssl: true,
      log_headers: false,
      log_bodies: false
    }.freeze

    def initialize(**options)
      @options = DEFAULTS.merge(options)

      yield self if block_given?
    end

    def verify!
      return if @options[:url].to_s.size.positive?

      raise ConfigError, 'Missing url in DruidConfig'
    end

    def keys
      @options.keys
    end

    def [](key)
      @options[key]
    end
  end
end
