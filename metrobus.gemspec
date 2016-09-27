# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'metrobus/version'

Gem::Specification.new do |spec|
  spec.name = 'metrobus'
  spec.version       = Metrobus::VERSION
  spec.authors       = ['sbower']
  spec.email         = ['shawn.bower@gmail.com']

  spec.summary       = 'Small Library to wrap the metrotransit.org web services'
  spec.description   = 'Small Library to wrap the metrotransit.org web services'
  spec.homepage      = 'https://github.com/sbower/metrobus'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.metadata['yard.run'] = 'yri'

  spec.add_dependency 'rest-client'

  spec.add_development_dependency 'webmock'
  spec.add_development_dependency 'bundler', '~> 1.12'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'coveralls'
  spec.add_development_dependency 'rubocop', '~> 0.40.0'
  spec.add_development_dependency 'yard', '~> 0.9.0'
end
