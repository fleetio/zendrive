# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'zendrive/version'

Gem::Specification.new do |spec|
  spec.name          = "zendrive"
  spec.version       = Zendrive::VERSION
  spec.authors       = ["Jorge Valdivia"]
  spec.email         = ["jvaldivia@fleetio.com"]

  spec.summary       = %q{Wrapper for the Zendrive API.}
  spec.description   = %q{Provides methods to interact with the Zendrive analytics API.}
  spec.homepage      = "https://www.fleetio.com"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.9"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "rest-client"
  spec.add_dependency "json"
end
