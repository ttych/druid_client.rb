# frozen_string_literal: true

require 'faraday'

require_relative 'response'

module DruidClient
  module Api
    class RestClient
      MAX_RETRIES = 0

      attr_reader :url, :options

      def initialize(url:, **options)
        @url = url
        @options = options
      end

      def get(path, params: {}, headers: {})
        request(:get, path, params: params, headers: headers)
      end

      def post(path, body: nil, headers: {})
        request(:post, path, body: body, headers: headers)
      end

      def put(path, body: nil, headers: {})
        request(:put, path, body: body, headers: headers)
      end

      def patch(path, body: nil, headers: {})
        request(:patch, path, body: body, headers: headers)
      end

      def delete(path, params: {}, headers: {})
        request(:delete, path, params: params, headers: headers)
      end

      def request(method, path, body: nil, params: {}, headers: {})
        File.join(url, path)
        start_time = Time.now
        response = client.send(method) do |req|
          req.url path
          req.headers.merge!(headers)
          req.body = body.to_json if body
        end
        elapsed_time = Time.now - start_time
        Response.new(
          status_code: response.status,
          headers: response.headers,
          body: response.body,
          elapsed_time: elapsed_time
        )
      rescue Faraday::Error => e
        elapsed_time = Time.now - start_time
        Response.new(status_code: 0, body: e.message, elapsed_time: elapsed_time)
      end

      def client
        @client ||= Faraday.new(url: base_url) do |conn|
          conn.request :authorization, :basic, basic_username, basic_password if basic_auth?
          conn.headers = base_headers
          conn.adapter Faraday.default_adapter
          conn.response :logger if ENV['DEBUG']
        end
      end

      def base_url
        url
      end

      def base_headers
        options[:headers] || {}
      end

      def basic_auth?
        basic_username && basic_password
      end

      def basic_username
        options[:username]
      end

      def basic_password
        options[:password]
      end

      class << self
        def from_druid_config(druid_config)
          new(**druid_config.to_h)
        end
      end
    end
  end
end
