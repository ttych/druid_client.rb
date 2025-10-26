# frozen_string_literal: true

require_relative 'output_format_factory'

module DruidClient
  class Cli
    class Sql
      def initialize(parent: nil)
        @parent = parent
      end

      def query(query:, options: {})
        query_body = { query: query }
        query_response = client.sql.query(
          **query_body
        )

        unless  query_response.success?
          display_error(
            status_code: query_response.status_code,
            error_message: query_response.body
          )
          return
        end

        formater = DruidClient::CLi::OutputFormatFactory.create(options.fetch(:format, :table))
        puts formater.format(query_response.body)
      end

      def display_error(status_code: , error_message: )
        puts "failed: status_code:#{status_code}, message:#{error_message}"
      end

      def client
        @parent.client
      end
    end
  end
end
