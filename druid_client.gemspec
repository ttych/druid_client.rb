# frozen_string_literal: true

require_relative 'lib/druid_client/version'

Gem::Specification.new do |spec|
  spec.name = 'druid_client'
  spec.version = DruidClient::VERSION
  spec.authors = ['Thomas Tych']
  spec.email = ['thomas.tych@gmail.com']

  spec.summary = 'Apache Druid DB client'
  spec.description = spec.summary
  spec.homepage = 'https://gitlab.com/ttych/druid_client.rb'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 3.2.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = spec.homepage
  # spec.metadata["changelog_uri"] = "#{spec.homepage}/CHANGELOG.md"

  # spec.metadata["allowed_push_host"] = "TODO: Set to your gem server 'https://example.com'"
  spec.metadata['rubygems_mfa_required'] = 'true'

  gemspec = File.basename(__FILE__)
  spec.files = IO.popen(%w[git ls-files -z], chdir: __dir__, err: IO::NULL) do |ls|
    ls.readlines("\x0", chomp: true).reject do |f|
      (f == gemspec) ||
        f.start_with?(*%w[bin/ Gemfile .gitignore test/ .gitlab-ci.yml .rubocop.yml])
    end
  end
  spec.bindir = 'exe'
  spec.executables = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bump', '~> 0.10.0'
  spec.add_development_dependency 'byebug', '~> 12.0'
  spec.add_development_dependency 'irb', '~> 1.15', '>= 1.15.2'
  spec.add_development_dependency 'minitest', '~> 5.25', '>= 5.25.5'
  spec.add_development_dependency 'minitest-focus', '~> 1.4'
  spec.add_development_dependency 'rake', '~> 13.3'
  spec.add_development_dependency 'rubocop', '~> 1.81', '>= 1.81.1'
  spec.add_development_dependency 'rubocop-minitest', '~> 0.38', '>= 0.38.2'
  spec.add_development_dependency 'rubocop-rake', '~> 0.7', '>= 0.7.1'
  spec.add_development_dependency 'simplecov', '~> 0.22'

  spec.add_dependency 'faraday', '~> 2.14'
  spec.add_dependency 'gli', '~> 2.22', '>= 2.22.2'
  spec.add_dependency 'terminal-table', '~> 4.0'
end
