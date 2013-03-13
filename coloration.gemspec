# -*- encoding: utf-8 -*-
require File.join(File.dirname(__FILE__), "lib", "coloration", "version.rb")

Gem::Specification.new do |s|
  s.name = %q{coloration}
  s.version = "#{Coloration::VERSION}"
  s.platform = Gem::Platform::RUBY
  s.required_ruby_version = Gem::Requirement.new("~> 1.9")
  s.date = %q{2013-03-13}
  s.authors = ["Marcin Kulik"]
  s.email = %q{marcin.kulik@gmail.com}
  s.has_rdoc = false
  s.homepage = %q{http://github.com/sickill/coloration}
  s.description = %q{Color scheme converters for vim, textmate, kate/kwrite, jedit}
  s.summary = %q{Color scheme converters for vim, textmate, kate/kwrite, jedit}
  s.executables = Dir["bin/*"].map { |f| File.basename(f) }
  s.files = Dir["bin/*"] + Dir["lib/**/*.rb"] + ["README.md"]
  s.add_dependency 'textpow19', '>= 0.11'
  s.add_dependency 'color-tools', '>= 1.3.0'
  s.add_dependency 'plist', '>= 3.1.0'
end
