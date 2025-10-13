# frozen_string_literal: true

require_relative 'resource'

module DruidClient
  module Api
    class Sql < Resource
      SQL_PATH = '/druid/v2/sql'

      QUERY_RESULT_FORMATS = %i[object
                                array
                                objectLines
                                arrayLines
                                csv].freeze
      QUERY_RESULT_FORMAT = QUERY_RESULT_FORMATS.first
      QUERY_HEADER = true
      QUERY_TYPES_HEADER = true
      QUERY_SQL_TYPES_HEADER = true
      QUERY_PARAMETERS = [].freeze
      QUERY_CONTEXT = {}.freeze

      def query(query:,
                result_format: QUERY_RESULT_FORMAT,
                header: QUERY_HEADER,
                types_header: QUERY_TYPES_HEADER,
                sql_types_header: QUERY_SQL_TYPES_HEADER,
                parameters: QUERY_PARAMETERS,
                context: QUERY_CONTEXT)
        query_body = {
          query: query.to_s,
          parameters: parameters.to_a,
          resultFormat: result_format.to_s,
          header: header,
          typesHeader: header && types_header,
          sqlTypesHeader: header && sql_types_header,
          context: context.to_h
        }
        post(SQL_PATH, body: query_body)
      end

      def cancel_query(query_id:)
        delete("#{SQL_PATH}/#{query_id}")
      end
    end
  end
end
