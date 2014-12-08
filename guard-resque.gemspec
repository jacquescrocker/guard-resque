# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "guard/resque/version"

Gem::Specification.new do |s|
  s.name        = "guard-resque"
  s.version     = Guard::ResqueVersion::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Jacques Crocker", "Ryan Long", "David Parry", "Jim Deville"]
  s.email       = ["railsjedi@gmail.com", 'ryan@rtlong.com', 'james.deville@gmail.com']
  s.homepage    = 'http://github.com/railsjedi/guard-resque'
  s.summary     = %q{guard gem for resque}
  s.description = %q{Guard::Resque automatically starts/stops/restarts resque worker}

  s.required_rubygems_version = '>= 1.3.6'
  s.rubyforge_project = "guard-resque"

  s.add_dependency 'guard', '>= 2.0'
  s.add_dependency 'resque'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec',         '~> 2.5.0'
  s.add_development_dependency 'guard-rspec',   '>= 0.2.0'
  s.add_development_dependency 'guard-bundler', '>= 0.1.1'

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
