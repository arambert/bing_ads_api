# Encoding: utf-8
require 'adcenter_api/errors'

module AdcenterApi; module V8; module AdministrationService
  class AdministrationServiceRegistry
    ADMINISTRATIONSERVICE_METHODS = {:get_assigned_quota=>{:input=>[], :output=>{:name=>"get_assigned_quota_response", :fields=>[]}, :original_name=>"GetAssignedQuota"}, :get_remaining_quota=>{:input=>[], :output=>{:name=>"get_remaining_quota_response", :fields=>[]}, :original_name=>"GetRemainingQuota"}}
    ADMINISTRATIONSERVICE_TYPES = {}
    ADMINISTRATIONSERVICE_NAMESPACES = []

    def self.get_method_signature(method_name)
      return ADMINISTRATIONSERVICE_METHODS[method_name.to_sym]
    end

    def self.get_type_signature(type_name)
      return ADMINISTRATIONSERVICE_TYPES[type_name.to_sym]
    end

    def self.get_namespace(index)
      return ADMINISTRATIONSERVICE_NAMESPACES[index]
    end
  end
end; end; end
