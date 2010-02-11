#!/usr/bin/env ruby

require File.dirname(__FILE__) + '/../lib/coloration'

if ARGV.size > 0
  converter = Coloration::Converters::Textmate2KatePartConverter.new
  converter.read(ARGV[0])
  converter.print
else
  puts "#{__FILE__} <textmate theme>"
end
