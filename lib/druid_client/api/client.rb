# frozen_string_literal: true

require_relative '../druid_config'
require_relative 'rest_client'
require_relative 'sql'

module DruidClient
  module Api
    class Client
      attr_reader :druid_config

      def initialize(druid_config:)
        @druid_config = druid_config
        @druid_config.verify!
      end

      def sql
        @sql ||= Api::Sql.new(rest_client: rest_client)
      end

      def rest_client
        @rest_client ||= RestClient.from_druid_config(druid_config)
      end

      class << self
        def build(**)
          druid_config = DruidConfig.new(**)
          new(druid_config: druid_config)
        end
      end
    end
  end
end
