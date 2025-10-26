# frozen_string_literal: true

require_relative 'api'
require_relative 'cli/sql'

module DruidClient
  class Cli
    def initialize(options: {})
      @options = options
    end

    def sql
      @sql ||= Cli::Sql.new(parent: self)
    end

    def client
      @client ||= DruidClient::Api.new(
          url: @options[:url],
          username: @options[:username],
          password: @options[:password],
      )
    end
  end
end
