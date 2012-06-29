# Encoding: utf-8
require 'ads_common/savon_service'
require 'adcenter_api/v8/reporting_service_registry'

module AdcenterApi; module V8; module ReportingService
  class ReportingService < AdsCommon::SavonService
    def initialize(config, endpoint)
      namespace = 'https://adcenter.microsoft.com/v8'
      super(config, endpoint, namespace, :v8)
    end

    def submit_generate_report(*args, &block)
      return execute_action('submit_generate_report', args, &block)
    end

    def poll_generate_report(*args, &block)
      return execute_action('poll_generate_report', args, &block)
    end

    private

    def get_service_registry()
      return ReportingServiceRegistry
    end

    def get_module()
      return AdcenterApi::V8::ReportingService
    end
  end
end; end; end
