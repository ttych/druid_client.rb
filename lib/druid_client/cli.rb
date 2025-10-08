# frozen_string_literal: true

require_relative 'cli/inputer'

module DruidClient
  class Cli
    def initialize(global_options: {})
      @global_options = global_options
    end

    def sql_query(query: '',
                  options: {})
      query = Inputer.new.read('Enter your query:') if query.to_s.empty?

      client.sql_query(query: query,
                       **options)
    end

    def client
      @client ||= DruidClient.new(
        url: @global_options[:url],
        username: @global_options[:username],
        password: @global_options[:password]
      )
    end
  end
end
