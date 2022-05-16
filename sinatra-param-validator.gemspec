# frozen_string_literal: true

require_relative 'lib/sinatra/param_validator'

Gem::Specification.new do |spec|
  spec.name = 'sinatra-param-validator'
  spec.version = Sinatra::ParamValidator::VERSION
  spec.authors = ['Rick Selby']
  spec.email = ['rick@selby-family.co.uk']

  spec.summary = 'Validation of parameters for Sinatra'
  spec.homepage = 'https://github.com/rickselby/sinatra-param_validator-validator'
  spec.license = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['changelog_uri'] = 'https://github.com/rickselby/sinatra-param_validator-validator/CHANGELOG.md'
  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/rickselby/sinatra-param_validator-validator'
  spec.metadata['rubygems_mfa_required'] = 'true'

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(__dir__) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:spec/|\.git|appveyor)})
    end
  end
  spec.require_paths = ['lib']

  # Uncomment to register a new dependency of your gem
  # spec.add_dependency "example-gem", "~> 1.0"
end
