# Encoding: utf-8
require 'adcenter_api/errors'

module AdcenterApi; module V8; module OptimizerService
  class OptimizerServiceRegistry
    OPTIMIZERSERVICE_METHODS = {:get_budget_opportunities=>{:input=>[], :output=>{:name=>"get_budget_opportunities_response", :fields=>[]}, :original_name=>"GetBudgetOpportunities"}, :get_bid_opportunities=>{:input=>[], :output=>{:name=>"get_bid_opportunities_response", :fields=>[]}, :original_name=>"GetBidOpportunities"}, :apply_budget_opportunities=>{:input=>[], :output=>{:name=>"apply_budget_opportunities_response", :fields=>[]}, :original_name=>"ApplyBudgetOpportunities"}, :apply_opportunities=>{:input=>[], :output=>{:name=>"apply_opportunities_response", :fields=>[]}, :original_name=>"ApplyOpportunities"}}
    OPTIMIZERSERVICE_TYPES = {}
    OPTIMIZERSERVICE_NAMESPACES = []

    def self.get_method_signature(method_name)
      return OPTIMIZERSERVICE_METHODS[method_name.to_sym]
    end

    def self.get_type_signature(type_name)
      return OPTIMIZERSERVICE_TYPES[type_name.to_sym]
    end

    def self.get_namespace(index)
      return OPTIMIZERSERVICE_NAMESPACES[index]
    end
  end
end; end; end
