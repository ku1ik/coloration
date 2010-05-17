# -*- encoding: utf-8 -*-
require File.join(File.dirname(__FILE__), "lib", "coloration", "version.rb")

Gem::Specification.new do |s|
  s.name = %q{coloration}
  s.version = "#{Coloration::VERSION}"
  s.platform = Gem::Platform::RUBY
  s.date = %q{2010-05-17}
  s.authors = ["Marcin Kulik"]
  s.email = %q{marcin.kulik@gmail.com}
  s.has_rdoc = false
  s.homepage = %q{http://github.com/sickill/coloration}
  s.summary = %q{Color scheme converters for vim, textmate, kate/kwrite, jedit}
  s.executables = Dir["bin/*"].map { |f| File.basename(f) }
  s.files = Dir["bin/*"] + Dir["lib/**/*.rb"] + ["README.md"]
  s.add_dependency 'textpow'#, '>= 1.0'
  s.add_dependency 'color-tools'#, '>= 0.5'
end
