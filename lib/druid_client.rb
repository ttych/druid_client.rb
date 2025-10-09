# frozen_string_literal: true

require_relative 'druid_client/version'
require_relative 'druid_client/api'

module DruidClient
  def self.api(...)
    DruidClient::Api.new(...)
  end
end
