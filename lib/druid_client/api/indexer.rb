# frozen_string_literal: true

require_relative 'component'

module Druid
  module Client
    module Api
      class Indexer < Component
        def tasks
          get('/druid/indexer/v1/tasks')
        end

        def task_status(task_id)
          get("/druid/indexer/v1/task/#{task_id}/status")
        end
      end
    end
  end
end
