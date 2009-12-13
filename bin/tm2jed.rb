#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../lib/coloration'

if ARGV.size > 0
  puts Coloration::JEditTheme.new(Coloration::TextMateTheme.parse(File.read(ARGV[0]))).to_s
else
  puts "#{__FILE__} <textmate theme>"
end
