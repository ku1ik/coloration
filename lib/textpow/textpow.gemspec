Gem::Specification.new do |s|
    s.name              = 'textpow'
    s.author            = %q(spox)
    s.email             = %q(spox@modspox.com)
    s.version           = '0.10.3'
    s.summary           = %q(textpow)
    s.platform          = Gem::Platform::RUBY
    s.has_rdoc          = true
    s.files             = ['bin/plist2yaml', 'bin/plist2syntax', 'README.txt', 'History.txt', 'lib/textpow.rb', 'lib/textpow/score_manager.rb', 'lib/textpow/syntax.rb', 'lib/textpow/debug_processor.rb', 'Manifest.txt']
    s.rdoc_options      = %w(--title TextPow --main README.txt --line-numbers)
    s.extra_rdoc_files  = %w(README.txt)
    s.require_paths     = %w(lib)
    s.executables       = %w(plist2yaml plist2syntax)
    s.required_ruby_version = '>= 1.9.0'
    s.add_dependency 'spox-plist'
    s.description = "Textpow is a library to parse and process Textmate bundles."
end