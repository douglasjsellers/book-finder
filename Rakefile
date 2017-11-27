require './lib/book-finder'
require "bundler/setup"


task :test_specs do
  puts "Running specs"
  puts `spec tests/specs/*.rb --backtrace`
end

desc "Run all of the tests"
task :test => [:test_specs] do
end

task :default => [:test]
