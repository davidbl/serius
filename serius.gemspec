# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'serius/version'

Gem::Specification.new do |gem|
  gem.name          = "serius"
  gem.version       = Serius::VERSION
  gem.authors       = ["David Blackmon"]
  gem.email         = ["davidkblackmon@gmail.com"]
  gem.description   = %q{infinite series for ruby}
  gem.summary       = %q{infinite series for ruby}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  
  gem.add_development_dependency "rspec"
  
end
