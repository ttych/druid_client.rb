# frozen_string_literal: true

require 'simplecov'

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(
  [SimpleCov::Formatter::HTMLFormatter]
)
SimpleCov.start do
  add_filter '/test/'
end

$LOAD_PATH.unshift File.expand_path('../lib', __dir__)
require 'druid_client'

require 'minitest/autorun'
