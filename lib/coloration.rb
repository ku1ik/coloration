require 'color'

require "coloration/extensions.rb"
require "coloration//style.rb"
require "coloration/abstract_converter.rb"
require "coloration/color_rgba.rb"

dir = File.dirname(__FILE__)
Dir["#{dir}/coloration/readers/*.rb"].each { |f| require f }
Dir["#{dir}/coloration/writers/*.rb"].each { |f| require f }
Dir["#{dir}/coloration/converters/*.rb"].each { |f| require f }
