# frozen_string_literal: true

require_relative 'api/client'

module DruidClient
  module Api
    def self.new(url: ,
        username: nil,
        password: nil,
        **options)
      DruidClient::Api::Client.new(
        url: url,
        username: username,
        password: password,
        **options)
    end
  end
end
