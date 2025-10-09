# frozen_string_literal: true

require 'faraday'

require_relative 'response'

module DruidClient
  module Api
    class RestClient
      attr_reader :url, :log, :options

      def initialize(options = {})
        @options = options
        @url = options[:url]
        @log = options[:log]
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

      def client_options
        {
          url: url,
          headers: { 'User-Agent' => user_agent }.compact,
          request: { timeout: timeout }.compact,
          ssl: { ca_file: ca_file,
                 ca_path: ca_path,
                 verify: verify_ssl }.compact
        }
      end

      def client
        @client ||= Faraday.new(client_options) do |conn|
          conn.request :authorization, :basic, basic_username, basic_password if basic_auth?
          conn.request :json
          conn.response :json
          if log
            conn.response :logger, log, headers: options[:log_headers], bodies: options[:log_bodies],
                                        log_level: :debug
          end
          conn.adapter Faraday.default_adapter
        end
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

      def user_agent
        options[:user_agent]
      end

      def timeout
        options[:timeout]
      end

      def ca_file
        options[:ca_file]
      end

      def ca_path
        options[:ca_path]
      end

      def verify_ssl
        options[:verify_ssl]
      end
    end
  end
end
