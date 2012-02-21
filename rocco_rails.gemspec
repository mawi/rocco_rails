# -*- encoding: utf-8 -*-
require File.expand_path('../lib/rocco_rails/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Mawi Marin"]
  gem.email         = ["mawitu@gmail.com"]
  gem.description   = "Rocco gem for rails"
  gem.summary       = gem.description
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "rocco_rails"
  gem.require_paths = ["lib"]
  gem.version       = RoccoRails::VERSION

  gem.add_dependency 'rocco'
  gem.add_dependency 'redcarpet', '~> 1.17'
  gem.add_dependency 'mustache'
end
