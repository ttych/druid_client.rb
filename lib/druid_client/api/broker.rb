# frozen_string_literal: true

require_relative 'component'

module Druid
  module Client
    module Api
      class Broker < Component
        def query(query_body)
          post('/druid/v2', query_body)
        end
      end
    end
  end
end
