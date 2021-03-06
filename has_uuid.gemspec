# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'has_uuid/version'

Gem::Specification.new do |spec|
  spec.name          = "rails_has_uuid"
  spec.version       = HasUuid::VERSION
  spec.authors       = ["Myles Eftos"]
  spec.email         = ["myles@madpilot.com.au"]

  spec.summary       ="A gem to help you retrofit UUIDs to your existing Rails application. "
  spec.description   ="A gem to help you retrofit UUIDs to your existing Rails application. "
  spec.homepage      = "http://github.com/madpilot/has_uuid"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "uuidtools"
  spec.add_dependency "activeuuid"

  spec.add_development_dependency "bundler", "~> 1.11"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "appraisal", "~> 2.1.0"
  spec.add_development_dependency "sqlite3"
  spec.add_development_dependency "database_cleaner"
  spec.add_development_dependency "mocha"
end
