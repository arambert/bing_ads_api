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
  rdoc.title    = 'AdcenterApi'
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

lib = File.expand_path('../lib/', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

# GENERATE API SERVICES
require 'adcenter_api/api_config'
require 'ads_common_for_adcenter/api_config'
require 'ads_common_for_adcenter/build/savon_registry'
desc 'Generate the Adcenter API stubs.'

task :generate do
  logger = Logger.new(STDOUT)
  logger.level = Logger::INFO
  api_config = AdcenterApi::ApiConfig
  versions = api_config.versions()
  versions.each do |version|
    code_path = 'lib/%s/%s' % [api_config.api_name.to_s.snakecase, version]
    wsdls = AdcenterApi::ApiConfig.get_wsdls(version)
    wsdls.each do |service_name, wsdl_url|
      logger.info('Processing %s at [%s]...' % [service_name, wsdl_url])
      generator = AdsCommonForAdcenter::Build::SavonGenerator.new(wsdl_url, code_path, api_config.api_name, version, service_name)
      generator.process_wsdl()
    end
  end
end
