# frozen_string_literal: true

require_relative 'error'

require 'faraday'
require 'faraday/retry'

module DruidClient
  class RestClient
    TIMEOUT = 30
    MAX_RETRIES = 3
    RETRY_INTERVAL = 0.05
    RETRY_BACKOFF_FACTOR = 2
    LOGGER_ENABLED = false

    FARADAY_OPTIONS = %i[request proxy ssl builder headers params].freeze

    attr_reader :url, :options

    def initialize(url, options = {})
      @url = url
      @options = options
    end

    def client
      @client ||= Faraday.new(url, faraday_options) do |conn|
        if basic_auth?
          conn.request :authorization, :basic, @options[:username],
                       @options[:password]
        end

        # Request middleware
        conn.request :json
        conn.request :retry, retry_options
        conn.request :instrumentation if instrumentation_enabled?

        # Response middleware
        conn.response :json, content_type: /\bjson$/
        conn.response :raise_error
        conn.response :logger if logger_enabled?

        # Adapter
        conn.adapter Faraday.default_adapter
      end
    end

    def get(path, params = {}, headers = {})
      with_error_handling do
        response = client.get(path, params, headers) do |req|
          yield req if block_given?
        end
        response.body
      end
    end

    def post(path, body = {}, headers = {})
      with_error_handling do
        response = client.post(path, body, headers) do |req|
          yield req if block_given?
        end
        response.body
      end
    end

    def delete(path, headers = {})
      with_error_handling do
        response = client.delete(path, headers) do |req|
          yield req if block_given?
        end
        response.body
      end
    end

    def put(path, body = {}, headers = {})
      with_error_handling do
        response = client.put(path, body, headers) do |req|
          yield req if block_given?
        end
        response.body
      end
    end

    def patch(path, body = {}, headers = {})
      with_error_handling do
        response = client.put(path, body, headers) do |req|
          yield req if block_given?
        end
        response.body
      end
    end

    private

    def faraday_options
      {
        request: {
          timeout: TIMEOUT,
          open_timeout: TIMEOUT
        }
      }.merge(options)
        .select { |k, _| FARADAY_OPTIONS.include?(k.to_sym) || FARADAY_OPTIONS.include?(k.to_s) }
    end

    def basic_auth?
      options[:username] && options[:password]
    end

    def token_auth?
      options[:token]
    end

    def instrumentation_enabled?
      options.key?(:instrumentation)
    end

    def retry_options
      {
        max: options.fetch(:max_retries, MAX_RETRIES),
        interval: options.fetch(:retry_interval, RETRY_INTERVAL),
        backoff_factor: options.fetch(:retry_backoff_factor, RETRY_BACKOFF_FACTOR),
        exceptions: [Faraday::TimeoutError, Faraday::ConnectionFailed, Faraday::UnauthorizedError]
      }
    end

    def logger_enabled?
      options.fetch(:logger, LOGGER_ENABLED)
    end

    def with_error_handling
      yield
    rescue Faraday::UnauthorizedError => e
      raise Druid::Client::AuthenticationError, "Authentication failed: #{e.message}"
    rescue Faraday::ForbiddenError => e
      raise Druid::Client::AuthorizationError, "Authorization failed: #{e.message}"
    rescue Faraday::ResourceNotFound => e
      raise Druid::Client::NotFoundError, e.message
    rescue Faraday::ConnectionFailed => e
      raise Druid::Client::ConnectionError, e.message
    rescue Faraday::TimeoutError => e
      raise Druid::Client::TimeoutError, e.message
    rescue Faraday::ClientError => e
      raise Druid::Client::BadRequestError, e.message
    rescue Faraday::Error => e
      raise Druid::Client::Error, e.message
    end
  end
end
