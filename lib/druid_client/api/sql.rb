# frozen_string_literal: true

require_relative 'resource'
require_relative 'sql_query_context'

module DruidClient
    module Api
      class Sql < Resource
        RESULT_FORMATS = %i[object array objectLines arrayLines csv].freeze

        def query(sql_query, parameters: [], result_format: :object, header: true,
                  types_header: true, sql_types_header: true, context: SqlQueryContext.new)
          validate_result_format(result_format)

          query_body = {
            query: sql_query.to_s,
            parameters: parameters.to_a,
            resultFormat: result_format.to_s,
            header: header,
            typesHeader: types_header,
            sqlTypesHeader: sql_types_header,
            context: context.to_h
          }

          post('/druid/v2/sql', query_body)
        end

        def cancel_query(sql_query_id)
          delete("/druid/v2/sql/#{sql_query_id}")
        end

        private

        def validate_result_format(result_format)
          return if RESULT_FORMATS.include?(result_format.to_sym)

          raise Druid::Client::BadRequestError,
                "in Sql.query, result_format #{result_format} is invalid"
        end
      end
    end
end
