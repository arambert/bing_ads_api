# Encoding: utf-8
require 'ads_common/savon_service'
require 'adcenter_api/v8/bulk_service_registry'

module AdcenterApi; module V8; module BulkService
  class BulkService < AdsCommon::SavonService
    def initialize(config, endpoint)
      namespace = 'https://adcenter.microsoft.com/v8'
      super(config, endpoint, namespace, :v8)
    end

    def download_campaigns_by_account_ids(*args, &block)
      return execute_action('download_campaigns_by_account_ids', args, &block)
    end

    def download_campaigns_by_campaign_ids(*args, &block)
      return execute_action('download_campaigns_by_campaign_ids', args, &block)
    end

    def get_download_status(*args, &block)
      return execute_action('get_download_status', args, &block)
    end

    private

    def get_service_registry()
      return BulkServiceRegistry
    end

    def get_module()
      return AdcenterApi::V8::BulkService
    end
  end
end; end; end
