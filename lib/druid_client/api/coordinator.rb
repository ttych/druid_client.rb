# frozen_string_literal: true

require_relative 'component'

module Druid
  module Client
    module Api
      class Coordinator < Component
        def datasources
          get('/druid/coordinator/v1/datasources')
        end

        def segments(datasource)
          get("/druid/coordinator/v1/datasources/#{datasource}/segments")
        end

        def loadstatus
          get('/druid/coordinator/v1/loadstatus')
        end
      end
    end
  end
end
