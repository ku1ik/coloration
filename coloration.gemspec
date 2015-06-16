# -*- encoding: utf-8 -*-
require File.join(File.dirname(__FILE__), "lib", "coloration", "version.rb")

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

Gem::Specification.new do |s|
  s.name        = %q{coloration}
  s.version     = "#{Coloration::VERSION}"
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["Marcin Kulik", "Gavin Laking"]
  s.email       = ['marcin.kulik@gmail.com', 'gavinlaking@gmail.com']
  s.has_rdoc    = false
  s.homepage    = %q{http://github.com/sickill/coloration}
  s.description = %q{Color scheme converters for vim, textmate, kate/kwrite, jedit}
  s.summary     = %q{Color scheme converters for vim, textmate, kate/kwrite, jedit}
  s.executables = Dir["bin/*"].map { |f| File.basename(f) }
  s.files       = Dir["bin/*"] + Dir["lib/**/*.rb"] + ["README.md"]

  s.add_development_dependency 'bundler',           '~> 1.8'
  s.add_development_dependency 'guard',             '2.12.6'
  s.add_development_dependency 'guard-bundler',     '2.1.0'
  s.add_development_dependency 'guard-minitest',    '2.4.4'
  s.add_development_dependency 'minitest',          '5.7.0'
  s.add_development_dependency 'mocha',             '1.1.0'
  s.add_development_dependency 'rake',              '10.4.2'
  s.add_development_dependency 'rubocop',           '0.32.0'
  s.add_development_dependency 'simplecov',         '0.10.0'
  s.add_development_dependency 'simplecov-console', '0.2.0'
  s.add_development_dependency 'yard',              '0.8.7.6'

  s.add_dependency 'textpow19',   '>= 0.11'
  s.add_dependency 'plist',       '>= 3.1.0'
end
