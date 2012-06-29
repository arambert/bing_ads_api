# Encoding: utf-8
require 'adcenter_api/errors'

module AdcenterApi; module V7; module ReportingService
  class ReportingServiceRegistry
    REPORTINGSERVICE_METHODS = {:submit_generate_report=>{:input=>[], :output=>{:name=>"submit_generate_report_response", :fields=>[]}, :original_name=>"SubmitGenerateReport"}, :poll_generate_report=>{:input=>[], :output=>{:name=>"poll_generate_report_response", :fields=>[]}, :original_name=>"PollGenerateReport"}}
    REPORTINGSERVICE_TYPES = {}
    REPORTINGSERVICE_NAMESPACES = []

    def self.get_method_signature(method_name)
      return REPORTINGSERVICE_METHODS[method_name.to_sym]
    end

    def self.get_type_signature(type_name)
      return REPORTINGSERVICE_TYPES[type_name.to_sym]
    end

    def self.get_namespace(index)
      return REPORTINGSERVICE_NAMESPACES[index]
    end
  end
end; end; end
