# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'scout_dogstatsd/version'

Gem::Specification.new do |spec|
  spec.name          = "scout_dogstatsd"
  spec.version       = ScoutDogstatsd::VERSION
  spec.authors       = ["Derek Haynes"]
  spec.email         = ["derek.haynes@gmail.com"]

  spec.summary       = %q{Reports app performance KPIs (response time, error rate, throughput, etc) via the DogStatsD client}
  spec.homepage      = "https://github.com/scoutapp/scout_dogstatsd_ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest"
  spec.add_development_dependency "mocha"

  spec.add_runtime_dependency "scout_apm", "~> 2.4.11.pre"
  spec.add_runtime_dependency "dogstatsd-ruby"
end
