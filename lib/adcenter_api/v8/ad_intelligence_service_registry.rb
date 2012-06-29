# Encoding: utf-8
require 'adcenter_api/errors'

module AdcenterApi; module V8; module AdIntelligenceService
  class AdIntelligenceServiceRegistry
    ADINTELLIGENCESERVICE_METHODS = {:get_publisher_keyword_performance=>{:input=>[], :output=>{:name=>"get_publisher_keyword_performance_response", :fields=>[]}, :original_name=>"GetPublisherKeywordPerformance"}, :suggest_keywords_for_url=>{:input=>[], :output=>{:name=>"suggest_keywords_for_url_response", :fields=>[]}, :original_name=>"SuggestKeywordsForUrl"}, :get_estimated_bid_by_keyword_ids=>{:input=>[], :output=>{:name=>"get_estimated_bid_by_keyword_ids_response", :fields=>[]}, :original_name=>"GetEstimatedBidByKeywordIds"}, :get_estimated_position_by_keyword_ids=>{:input=>[], :output=>{:name=>"get_estimated_position_by_keyword_ids_response", :fields=>[]}, :original_name=>"GetEstimatedPositionByKeywordIds"}, :get_estimated_bid_by_keywords=>{:input=>[], :output=>{:name=>"get_estimated_bid_by_keywords_response", :fields=>[]}, :original_name=>"GetEstimatedBidByKeywords"}, :get_estimated_position_by_keywords=>{:input=>[], :output=>{:name=>"get_estimated_position_by_keywords_response", :fields=>[]}, :original_name=>"GetEstimatedPositionByKeywords"}, :get_historical_search_count=>{:input=>[], :output=>{:name=>"get_historical_search_count_response", :fields=>[]}, :original_name=>"GetHistoricalSearchCount"}, :get_historical_search_count_by_device=>{:input=>[], :output=>{:name=>"get_historical_search_count_by_device_response", :fields=>[]}, :original_name=>"GetHistoricalSearchCountByDevice"}, :get_historical_keyword_performance=>{:input=>[], :output=>{:name=>"get_historical_keyword_performance_response", :fields=>[]}, :original_name=>"GetHistoricalKeywordPerformance"}, :get_historical_keyword_performance_by_device=>{:input=>[], :output=>{:name=>"get_historical_keyword_performance_by_device_response", :fields=>[]}, :original_name=>"GetHistoricalKeywordPerformanceByDevice"}, :suggest_keywords_from_existing_keywords=>{:input=>[], :output=>{:name=>"suggest_keywords_from_existing_keywords_response", :fields=>[]}, :original_name=>"SuggestKeywordsFromExistingKeywords"}, :get_keyword_locations=>{:input=>[], :output=>{:name=>"get_keyword_locations_response", :fields=>[]}, :original_name=>"GetKeywordLocations"}, :get_keyword_categories=>{:input=>[], :output=>{:name=>"get_keyword_categories_response", :fields=>[]}, :original_name=>"GetKeywordCategories"}, :get_keyword_demographics=>{:input=>[], :output=>{:name=>"get_keyword_demographics_response", :fields=>[]}, :original_name=>"GetKeywordDemographics"}}
    ADINTELLIGENCESERVICE_TYPES = {}
    ADINTELLIGENCESERVICE_NAMESPACES = []

    def self.get_method_signature(method_name)
      return ADINTELLIGENCESERVICE_METHODS[method_name.to_sym]
    end

    def self.get_type_signature(type_name)
      return ADINTELLIGENCESERVICE_TYPES[type_name.to_sym]
    end

    def self.get_namespace(index)
      return ADINTELLIGENCESERVICE_NAMESPACES[index]
    end
  end
end; end; end
