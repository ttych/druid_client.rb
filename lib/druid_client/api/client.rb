# frozen_string_literal: true

require_relative '../rest_client'
# require_relative 'coordinator'
# require_relative 'indexer'
# require_relative 'broker'
# require_relative 'historical'
# require_relative 'overlord'
require_relative 'sql'

module DruidClient
  module Api
    class Client
      attr_reader :url, :username, :password, :options

      def initialize(url:, username: nil, password: nil, **options)
        @url = url
        @username = username
        @password = password
        @options = options
      end

      def rest_client
        @rest_client = DruidClient::RestClient.new(
          url,
          options.merge(username: username, password: password)
        )
      end

      # def coordinator
      #   @coordinator ||= Api::Coordinator.new(self)
      # end

      # def indexer
      #   @indexer ||= Api::Indexer.new(self)
      # end

      # def broker
      #   @broker ||= Api::Broker.new(self)
      # end

      # def historical
      #   @historical ||= Api::Historical.new(self)
      # end

      # def overlord
      #   @overlord ||= Api::Overlord.new(self)
      # end

      def sql
        @sql ||= Api::Sql.new(rest_client)
      end
    end
  end
end
