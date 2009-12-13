require 'color'

dir = File.dirname(__FILE__)
require "#{dir}/theme.rb"
require "#{dir}/style.rb"
require "#{dir}/selector_hash.rb"
Dir["#{dir}/themes/*.rb"].each { |f| require f }
