# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name        = "configuratron"
  s.version     = "0.0.1"
  s.authors     = ["Grzesiek Kolodziejczyk"]
  s.email       = ["gkolodziejczyk@gmail.com"]
  s.homepage    = "https://github.com/grk/configuratron"
  s.summary     = %q{Configuration storage library}
  s.description = %q{Configuration storage library for Ruby with metaprogramming magic. Allows for hash-like and method-based key access.}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  s.add_development_dependency "rspec", ">= 2.6.0"
  s.add_development_dependency "guard-rspec"
  s.add_development_dependency "rake", ">= 0.9.2"
  s.add_development_dependency "bundler"
end
