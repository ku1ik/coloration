#!/usr/bin/env ruby

require "coloration"

if ARGV.size > 1
  converter = Coloration::Converters::Textmate2NetbeansConverter.new
  converter.read(ARGV[0])
  converter.write(ARGV[1])
else
  puts "#{__FILE__} <textmate theme> <netbeans theme>"
end
