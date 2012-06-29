# Encoding: utf-8
require 'adcenter_api/errors'

module AdcenterApi; module V8; module BulkService
  class BulkServiceRegistry
    BULKSERVICE_METHODS = {:download_campaigns_by_account_ids=>{:input=>[], :output=>{:name=>"download_campaigns_by_account_ids_response", :fields=>[]}, :original_name=>"DownloadCampaignsByAccountIds"}, :download_campaigns_by_campaign_ids=>{:input=>[], :output=>{:name=>"download_campaigns_by_campaign_ids_response", :fields=>[]}, :original_name=>"DownloadCampaignsByCampaignIds"}, :get_download_status=>{:input=>[], :output=>{:name=>"get_download_status_response", :fields=>[]}, :original_name=>"GetDownloadStatus"}}
    BULKSERVICE_TYPES = {}
    BULKSERVICE_NAMESPACES = []

    def self.get_method_signature(method_name)
      return BULKSERVICE_METHODS[method_name.to_sym]
    end

    def self.get_type_signature(type_name)
      return BULKSERVICE_TYPES[type_name.to_sym]
    end

    def self.get_namespace(index)
      return BULKSERVICE_NAMESPACES[index]
    end
  end
end; end; end
