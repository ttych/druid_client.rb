# frozen_string_literal: true

# rubocop:disable Metrics/BlockLength,Style/GlobalVars

# fake Druid API
# launch with ruby fake_druid_api.rb

require 'sinatra'

# SQL query
post '/druid/v2/sql' do
  $call_count ||= 0
  $call_count += 1
  case $call_count % 3
  when 0
    status 200
  when 1
    status 400
  when 2
    status 500
  end
  content_type :json
  auth = Rack::Auth::Basic::Request.new(request.env)
  username, password = auth.credentials if auth.provided? && auth.basic?

  response_headers = {
    'X-Custom-Header-1' => 'h1',
    'X-Custom-Header-2' => 'h2',
    'X-Custom-username' => username,
    'X-Custom-password' => password
  }

  headers response_headers
  [
    {
      my_count: {
        type: 'LONG',
        sqlType: 'BIGINT'
      }
    },
    {
      my_count: 123_456_789
    }
  ].to_json
end

# rubocop:enable all
