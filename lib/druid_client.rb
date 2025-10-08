# frozen_string_literal: true

require_relative 'druid_client/version'
require_relative 'druid_client/error'
require_relative 'druid_client/client'

module DruidClient
  def self.new(url:, username: nil, password: nil, **)
    Client.new(url: url,
               username: username,
               password: password,
               **)
  end
end
