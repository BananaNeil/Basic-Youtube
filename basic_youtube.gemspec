# -*- encoding: utf-8 -*-
require File.expand_path('../lib/basic_youtube/version', __FILE__)

Gem::Specification.new do |gem|
  gem.add_dependency "httparty"
  
  gem.authors       = ["Neil Johnson"]
  gem.email         = ["BananaNeil@gmail.com"]
  gem.description   = %q{Basic YouTube gem that allows for easy access to public information.}
  gem.summary       = %q{Provides easy access to Video views, comments, favorites, etc.., Channel subscribers, total views, channel vews, etc...}
  gem.homepage      = ""

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "basic_youtube"
  gem.require_paths = ["lib","lib/basic_youtube"]
  gem.version       = BasicYoutube::VERSION
end
