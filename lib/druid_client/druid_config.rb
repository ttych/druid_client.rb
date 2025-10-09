# frozen_string_literal: true

require_relative 'error'

module DruidClient
  class DruidConfig
    def initialize(**options)
      @options = options
      @url = @options[:url] || DEFAULT_URL
      @username = @options[:username] || DEFAULT_USERNAME
      @password = @options[:password] || DEFAULT_PASSWORD

      yield self if block_given?
    end

    def verify!
      raise ConfigError, 'Missing url in DruidConfig' if @url.empty?
    end

    def to_h
      @options
    end
  end
end
