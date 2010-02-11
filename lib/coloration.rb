require 'color'

dir = File.dirname(__FILE__)
require "#{dir}/extensions.rb"
#require "#{dir}/theme.rb"
require "#{dir}/style.rb"
require "#{dir}/abstract_converter.rb"
Dir["#{dir}/readers/*.rb"].each { |f| require f }
Dir["#{dir}/writers/*.rb"].each { |f| require f }
Dir["#{dir}/converters/*.rb"].each { |f| require f }
