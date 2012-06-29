# Encoding: utf-8
require 'ads_common/savon_service'
require 'adcenter_api/v8/ad_intelligence_service_registry'

module AdcenterApi; module V8; module AdIntelligenceService
  class AdIntelligenceService < AdsCommon::SavonService
    def initialize(config, endpoint)
      namespace = 'https://adcenter.microsoft.com/v8'
      super(config, endpoint, namespace, :v8)
    end

    def get_publisher_keyword_performance(*args, &block)
      return execute_action('get_publisher_keyword_performance', args, &block)
    end

    def suggest_keywords_for_url(*args, &block)
      return execute_action('suggest_keywords_for_url', args, &block)
    end

    def get_estimated_bid_by_keyword_ids(*args, &block)
      return execute_action('get_estimated_bid_by_keyword_ids', args, &block)
    end

    def get_estimated_position_by_keyword_ids(*args, &block)
      return execute_action('get_estimated_position_by_keyword_ids', args, &block)
    end

    def get_estimated_bid_by_keywords(*args, &block)
      return execute_action('get_estimated_bid_by_keywords', args, &block)
    end

    def get_estimated_position_by_keywords(*args, &block)
      return execute_action('get_estimated_position_by_keywords', args, &block)
    end

    def get_historical_search_count(*args, &block)
      return execute_action('get_historical_search_count', args, &block)
    end

    def get_historical_search_count_by_device(*args, &block)
      return execute_action('get_historical_search_count_by_device', args, &block)
    end

    def get_historical_keyword_performance(*args, &block)
      return execute_action('get_historical_keyword_performance', args, &block)
    end

    def get_historical_keyword_performance_by_device(*args, &block)
      return execute_action('get_historical_keyword_performance_by_device', args, &block)
    end

    def suggest_keywords_from_existing_keywords(*args, &block)
      return execute_action('suggest_keywords_from_existing_keywords', args, &block)
    end

    def get_keyword_locations(*args, &block)
      return execute_action('get_keyword_locations', args, &block)
    end

    def get_keyword_categories(*args, &block)
      return execute_action('get_keyword_categories', args, &block)
    end

    def get_keyword_demographics(*args, &block)
      return execute_action('get_keyword_demographics', args, &block)
    end

    private

    def get_service_registry()
      return AdIntelligenceServiceRegistry
    end

    def get_module()
      return AdcenterApi::V8::AdIntelligenceService
    end
  end
end; end; end
