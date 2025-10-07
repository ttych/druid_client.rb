# frozen_string_literal: true

require 'bundler/gem_tasks'
require 'minitest/test_task'

Minitest::TestTask.create(:test) do |t|
  t.libs << 'test'
  t.warning = false
  t.test_globs = ['test/**/*_test.rb', 'test/**/test_*.rb']
end

require 'rubocop/rake_task'

RuboCop::RakeTask.new

require 'bump/tasks'

task default: %i[test rubocop]
