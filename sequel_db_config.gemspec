# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'sequel_db_config/version'

Gem::Specification.new do |spec|
  spec.name          = "sequel_db_config"
  spec.version       = SequelDbConfig::VERSION
  spec.authors       = ["Kikuchi Ken"]
  spec.email         = ["ken@nuasa.org"]
  spec.summary       = %q{Sequel database configuration settings.}
  spec.description   = %q{Sequel database configuration settings.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.7"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "sequel"
end
