$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "signing_history/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "signing_history"
  s.version     = SigningHistory::VERSION
  s.authors     = ["Adrian Nowik"]
  s.email       = ["schab55@gmail.com"]
  s.homepage    = "http://www.2n.pl/"
  s.summary     = "Enginge for saving succeed and failed logins."
  s.description = "Enginge for saving succeed and failed logins."

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["spec/**/*"]

  s.add_dependency "rails", "~> 4.1.0"
  s.add_dependency "browser"
  s.add_dependency 'will_paginate-bootstrap'

end
