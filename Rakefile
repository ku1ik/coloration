require 'bundler/gem_tasks'
require 'rake/testtask'
require 'yard'

Rake::TestTask.new(:test) do |t|
  t.libs.push 'lib'
  t.libs.push 'test'
  t.pattern = 'test/**/*_test.rb'
  t.verbose = false
  t.warning = false # set to true for Ruby warnings (ruby -w)
end

YARD::Rake::YardocTask.new(:yard) do |t|
  t.files = [
    'lib/**/*.rb',
    '-',
  ]
end

task default: :test
