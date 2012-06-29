# encoding: UTF-8
require 'rubygems'
begin
  require 'bundler/setup'
rescue LoadError
  puts 'You must `gem install bundler` and `bundle install` to run rake tasks'
end

require 'rake'
require 'rdoc/task'
require "rspec/core/rake_task"

desc "Run all test with spec"
RSpec::Core::RakeTask.new('spec') do |spec|
  spec.rspec_opts = %w[--color]
  spec.pattern = 'spec/*_spec.rb'
end

desc "Run tests"
task :default => :spec

Rake::RDocTask.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'AdcenterApiClient'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end