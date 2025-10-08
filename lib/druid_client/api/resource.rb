# frozen_string_literal: true

require 'forwardable'

module DruidClient
  module Api
    class Resource
      extend Forwardable

      attr_reader :rest_client

      def_delegators :rest_client, :get, :post, :delete, :put, :patch

      def initialize(rest_client)
        @rest_client = rest_client
      end
    end
  end
end
