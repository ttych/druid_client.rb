# frozen_string_literal: true

require_relative 'api/client'

module DruidClient
  module Api
    def self.new(...)
      DruidClient::Api::Client.build(...)
    end
  end
end
