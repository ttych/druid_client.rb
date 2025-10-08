# frozen_string_literal: true

module DruidClient
    module Api
      # doc: https://druid.apache.org/docs/latest/querying/sql-query-context/
      class SqlQueryContext
        def initialize(**parameters)
          @parameters = parameters
        end

        def parameters
          @parameters
        end

        def to_h
          parameters
        end
      end
    end
end
