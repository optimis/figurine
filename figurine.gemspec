# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'figurine/version'

Gem::Specification.new do |spec|
  spec.name          = "figurine"
  spec.version       = Figurine::VERSION
  spec.authors       = ["Hubert Huang", "Ryan Moran"]
  spec.email         = ["hubert77@gmail.com", "ryan.moran@gmail.com"]
  spec.description   = %q{More intuitive replacement for accepts nested attributes}
  spec.summary       = %q{Big things coming...}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activemodel', '>= 3.0'

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency 'rspec'
end
