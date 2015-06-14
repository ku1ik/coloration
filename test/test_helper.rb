require 'simplecov'
require 'simplecov-console'
require 'minitest/autorun'
require 'minitest/pride' unless ENV['NO_COLOR']
require 'minitest/hell'

SimpleCov.start do
  formatter SimpleCov::Formatter::Console
  command_name 'MiniTest::Spec'
  add_filter   '/test/'
  add_group    'converters', 'coloration/converters'
  add_group    'readers',    'coloration/readers'
  add_group    'support',    'coloration/support'
  add_group    'writers',    'coloration/writers'
end unless ENV['no_simplecov']

module MiniTest
  class Spec
    # parallelize_me! # uncomment to unleash hell

    class << self
      alias_method :context, :describe
    end
  end
end

require 'mocha/setup'
require 'coloration'
