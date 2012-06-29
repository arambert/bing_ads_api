# Encoding: utf-8
require 'adcenter_api/errors'

module AdcenterApi; module V7; module CustomerManagementService
  class CustomerManagementServiceRegistry
    CUSTOMERMANAGEMENTSERVICE_METHODS = {:get_accounts_info=>{:input=>[], :output=>{:name=>"get_accounts_info_response", :fields=>[]}, :original_name=>"GetAccountsInfo"}, :add_account=>{:input=>[], :output=>{:name=>"add_account_response", :fields=>[]}, :original_name=>"AddAccount"}, :update_account=>{:input=>[], :output=>{:name=>"update_account_response", :fields=>[]}, :original_name=>"UpdateAccount"}, :get_customer=>{:input=>[], :output=>{:name=>"get_customer_response", :fields=>[]}, :original_name=>"GetCustomer"}, :update_customer=>{:input=>[], :output=>{:name=>"update_customer_response", :fields=>[]}, :original_name=>"UpdateCustomer"}, :signup_customer=>{:input=>[], :output=>{:name=>"signup_customer_response", :fields=>[]}, :original_name=>"SignupCustomer"}, :get_account=>{:input=>[], :output=>{:name=>"get_account_response", :fields=>[]}, :original_name=>"GetAccount"}, :get_customers_info=>{:input=>[], :output=>{:name=>"get_customers_info_response", :fields=>[]}, :original_name=>"GetCustomersInfo"}, :add_user=>{:input=>[], :output=>{:name=>"add_user_response", :fields=>[]}, :original_name=>"AddUser"}, :delete_account=>{:input=>[], :output=>{:name=>"delete_account_response", :fields=>[]}, :original_name=>"DeleteAccount"}, :delete_customer=>{:input=>[], :output=>{:name=>"delete_customer_response", :fields=>[]}, :original_name=>"DeleteCustomer"}, :update_user=>{:input=>[], :output=>{:name=>"update_user_response", :fields=>[]}, :original_name=>"UpdateUser"}, :update_user_roles=>{:input=>[], :output=>{:name=>"update_user_roles_response", :fields=>[]}, :original_name=>"UpdateUserRoles"}, :get_user=>{:input=>[], :output=>{:name=>"get_user_response", :fields=>[]}, :original_name=>"GetUser"}, :delete_user=>{:input=>[], :output=>{:name=>"delete_user_response", :fields=>[]}, :original_name=>"DeleteUser"}, :get_users_info=>{:input=>[], :output=>{:name=>"get_users_info_response", :fields=>[]}, :original_name=>"GetUsersInfo"}, :get_customer_pilot_feature=>{:input=>[], :output=>{:name=>"get_customer_pilot_feature_response", :fields=>[]}, :original_name=>"GetCustomerPilotFeature"}}
    CUSTOMERMANAGEMENTSERVICE_TYPES = {}
    CUSTOMERMANAGEMENTSERVICE_NAMESPACES = []

    def self.get_method_signature(method_name)
      return CUSTOMERMANAGEMENTSERVICE_METHODS[method_name.to_sym]
    end

    def self.get_type_signature(type_name)
      return CUSTOMERMANAGEMENTSERVICE_TYPES[type_name.to_sym]
    end

    def self.get_namespace(index)
      return CUSTOMERMANAGEMENTSERVICE_NAMESPACES[index]
    end
  end
end; end; end
