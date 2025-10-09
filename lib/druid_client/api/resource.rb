# frozen_string_literal: true

require 'forwardable'

module DruidClient
  module Api
    class Resource
      extend Forwardable

      def_delegators :@rest_client, :get, :post, :patch, :put, :delete

      def initialize(rest_client:)
        @rest_client = rest_client
      end
    end
  end
end
