#!/usr/bin/env ruby

require File.expand_path(File.dirname(__FILE__) + '/../lib/coloration')

if ARGV.size > 0
  converter = Coloration::Converters::Textmate2VimConverter.new
  converter.read(ARGV[0])
  converter.write
else
  puts "#{__FILE__} <textmate theme>"
end
