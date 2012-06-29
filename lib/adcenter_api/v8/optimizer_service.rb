# Encoding: utf-8
require 'ads_common/savon_service'
require 'adcenter_api/v8/optimizer_service_registry'

module AdcenterApi; module V8; module OptimizerService
  class OptimizerService < AdsCommon::SavonService
    def initialize(config, endpoint)
      namespace = 'https://adcenter.microsoft.com/v8'
      super(config, endpoint, namespace, :v8)
    end

    def get_budget_opportunities(*args, &block)
      return execute_action('get_budget_opportunities', args, &block)
    end

    def get_bid_opportunities(*args, &block)
      return execute_action('get_bid_opportunities', args, &block)
    end

    def apply_budget_opportunities(*args, &block)
      return execute_action('apply_budget_opportunities', args, &block)
    end

    def apply_opportunities(*args, &block)
      return execute_action('apply_opportunities', args, &block)
    end

    private

    def get_service_registry()
      return OptimizerServiceRegistry
    end

    def get_module()
      return AdcenterApi::V8::OptimizerService
    end
  end
end; end; end
