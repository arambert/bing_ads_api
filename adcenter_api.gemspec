# -*- encoding: utf-8 -*-
#
# Authors:: Adrien Rambert
#
# Copyright:: Copyright 2012, Weboglobin
#
# License:: Licensed under the Apache License, Version 2.0 (the "License");
#           you may not use this file except in compliance with the License.
#           You may obtain a copy of the License at
#
#           http://www.apache.org/licenses/LICENSE-2.0
#
#           Unless required by applicable law or agreed to in writing, software
#           distributed under the License is distributed on an "AS IS" BASIS,
#           WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
#           implied.
#           See the License for the specific language governing permissions and
#           limitations under the License.

lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'adcenter_api/version'

Gem::Specification.new do |s|
  s.name = 'adcenter'
  s.version = AdcenterApi::ApiConfig::CLIENT_LIB_VERSION
  s.summary = 'Ruby wrapper for Microsoft Adcenter API'
  s.description = 'Ruby wrapper for Microsoft Adcenter API'
  s.homepage = 'https://github.com/weboglobin/adcenter_api'
  s.authors = ['Adrien Rambert']
  s.email = ['arambert@optimeez.com']
  s.require_path = 'lib'
  s.files = Dir.glob('{lib,test}/**/*') + %w(Rakefile README)

  s.add_dependency('savon', '~> 1.0.0')
  s.add_dependency('httpi', '~> 1.0.0')
  s.add_dependency('google-ads-common')
  s.add_development_dependency 'rake'
  s.add_development_dependency 'rspec', '~> 2.8'
end