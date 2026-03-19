# frozen_string_literal: true

require_relative 'lib/legion/extensions/jfrog/version'

Gem::Specification.new do |spec|
  spec.name          = 'lex-jfrog'
  spec.version       = Legion::Extensions::Jfrog::VERSION
  spec.authors       = ['Esity']
  spec.email         = ['matthewdiverson@gmail.com']

  spec.summary       = 'LEX JFrog'
  spec.description   = 'Connects LegionIO to JFrog products (Artifactory, Xray, Pipelines)'
  spec.homepage      = 'https://github.com/LegionIO/lex-jfrog'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 3.4'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/LegionIO/lex-jfrog'
  spec.metadata['documentation_uri'] = 'https://github.com/LegionIO/lex-jfrog'
  spec.metadata['changelog_uri'] = 'https://github.com/LegionIO/lex-jfrog/blob/main/CHANGELOG.md'
  spec.metadata['bug_tracker_uri'] = 'https://github.com/LegionIO/lex-jfrog/issues'
  spec.metadata['rubygems_mfa_required'] = 'true'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_dependency 'faraday', '>= 2.0'
end
