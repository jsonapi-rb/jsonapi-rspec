version = File.read(File.expand_path('VERSION', __dir__)).strip

Gem::Specification.new do |spec|
  spec.name          = 'jsonapi-rspec'
  spec.version       = version
  spec.author        = ['Lucas Hosseini']
  spec.email         = ['lucas.hosseini@gmail.com']
  spec.summary       = 'RSpec matchers for JSON API.'
  spec.description   = 'Helpers for validating JSON API payloads'
  spec.homepage      = 'https://github.com/jsonapi-rb/jsonapi-rspec'
  spec.license       = 'MIT'

  spec.files         = Dir['README.md', 'lib/**/*']
  spec.require_path  = 'lib'

  spec.add_dependency 'rspec-core'
  spec.add_dependency 'rspec-expectations'

  spec.add_development_dependency 'rake'
  spec.add_development_dependency 'rspec'
  spec.add_development_dependency 'rubocop-performance'
  spec.add_development_dependency 'simplecov'

  spec.metadata = {
    'rubygems_mfa_required' => 'true'
  }
end
