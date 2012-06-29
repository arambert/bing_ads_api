require 'ads_common/savon_service'
require 'adwords_api/v8/customer_management_service_registry'

module AdwordsApi
  module V8
    module CustomerManagementService
      class CustomerManagementService < AdsCommon::SavonService
        def initialize(config, endpoint)
          namespace = 'https://sharedservices.adcenterapi.microsoft.com/Api/CustomerManagement/v8/CustomerManagementService.svc?wsdl'
          super(config, endpoint, namespace, :v8)
        end

        def get(*args, &block)
          return execute_action('get', args, &block)
        end

        def mutate(*args, &block)
          return execute_action('mutate', args, &block)
        end

        private

        def get_service_registry()
          return CustomerManagementServiceRegistry
        end

        def get_module()
          return AdcenterApi::V8::CustomerManagementService
        end
      end
      end
    end
end