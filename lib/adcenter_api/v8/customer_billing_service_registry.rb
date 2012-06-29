# Encoding: utf-8
require 'adcenter_api/errors'

module AdcenterApi; module V8; module CustomerBillingService
  class CustomerBillingServiceRegistry
    CUSTOMERBILLINGSERVICE_METHODS = {:get_invoices_info=>{:input=>[], :output=>{:name=>"get_invoices_info_response", :fields=>[]}, :original_name=>"GetInvoicesInfo"}, :get_invoices=>{:input=>[], :output=>{:name=>"get_invoices_response", :fields=>[]}, :original_name=>"GetInvoices"}, :get_display_invoices=>{:input=>[], :output=>{:name=>"get_display_invoices_response", :fields=>[]}, :original_name=>"GetDisplayInvoices"}, :add_insertion_order=>{:input=>[], :output=>{:name=>"add_insertion_order_response", :fields=>[]}, :original_name=>"AddInsertionOrder"}, :update_insertion_order=>{:input=>[], :output=>{:name=>"update_insertion_order_response", :fields=>[]}, :original_name=>"UpdateInsertionOrder"}, :get_insertion_orders_by_account=>{:input=>[], :output=>{:name=>"get_insertion_orders_by_account_response", :fields=>[]}, :original_name=>"GetInsertionOrdersByAccount"}, :get_kohio_invoices=>{:input=>[], :output=>{:name=>"get_kohio_invoices_response", :fields=>[]}, :original_name=>"GetKOHIOInvoices"}, :get_account_monthly_spend=>{:input=>[], :output=>{:name=>"get_account_monthly_spend_response", :fields=>[]}, :original_name=>"GetAccountMonthlySpend"}}
    CUSTOMERBILLINGSERVICE_TYPES = {}
    CUSTOMERBILLINGSERVICE_NAMESPACES = []

    def self.get_method_signature(method_name)
      return CUSTOMERBILLINGSERVICE_METHODS[method_name.to_sym]
    end

    def self.get_type_signature(type_name)
      return CUSTOMERBILLINGSERVICE_TYPES[type_name.to_sym]
    end

    def self.get_namespace(index)
      return CUSTOMERBILLINGSERVICE_NAMESPACES[index]
    end
  end
end; end; end
