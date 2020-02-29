
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'waves_ruby_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'waves_ruby_client'
  spec.version       = WavesRubyClient::VERSION
  spec.authors       = ['Philipp Großelfinger']
  spec.email         = ['philipp.grosselfinger@gmail.com']

  spec.summary       = 'Ruby Client for Waves Platform API'
  spec.description   = 'Access Waves Platform API with ruby'
  spec.homepage      = 'https://github.com/phigrofi/waves_ruby_client'
  spec.license       = 'MIT'

  spec.files = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'httparty'
  spec.add_dependency 'activemodel'
  spec.add_dependency 'activesupport'

  spec.add_development_dependency 'bundler', '~> 1.14'
  spec.add_development_dependency 'rake', '~> 13.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'guard-rspec'
end
