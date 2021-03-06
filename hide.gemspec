# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "hide/version"

Gem::Specification.new do |s|
  s.name        = "hide"
  s.version     = Hide::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Karel Minarik"]
  s.email       = ["karmi@karmi.cz"]
  s.homepage    = ""
  s.summary     = %q{Parse and index Jekyll pages into ElasticSearch}

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]


  s.add_dependency "jekyll", "> 0.10.0"
  s.add_dependency "slingshot-rb"

  s.add_development_dependency "turn"
  s.add_development_dependency "shoulda"
  s.add_development_dependency "mocha"
  s.add_development_dependency "sdoc"
  s.add_development_dependency "rcov"

end
