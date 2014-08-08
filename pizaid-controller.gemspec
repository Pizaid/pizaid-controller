# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'pizaid/controller/version'

Gem::Specification.new do |spec|
  spec.name          = "pizaid-controller"
  spec.version       = Pizaid::Controller::VERSION
  spec.authors       = ["Chikashi Shinagawa","Makoto Shimazu"]
  spec.email         = ["","makoto.shiamz@gmail.com"]
  spec.summary       = %q{Pizaid - RaspberryPi RAID System with Auxiliary Power}
  spec.description   = %q{Pizaid Disk Control Server: Pizaid - RaspberryPi RAID System with Auxiliary Power}
  spec.homepage      = "https://github.com/Pizaid"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"

  spec.add_runtime_dependency "thrift", "~>0.9.1"
end
