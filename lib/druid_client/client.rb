# frozen_string_literal: true

require_relative 'api'

module DruidClient
  class Client
    def initialize(url:, username: nil, password: nil, **options)
      @url = url
      @username = username
      @password = password
      @options = options
    end

    def sql_query(query: nil,
                  **options)
      api.sql.query(query)
        end

    def api
      @api ||= DruidClient::Api.new(
        url: @url,
        username: @username,
        password: @password,
        **@options
      )
    end
  end
end
