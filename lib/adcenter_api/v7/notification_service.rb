# Encoding: utf-8
require 'ads_common/savon_service'
require 'adcenter_api/v7/notification_service_registry'

module AdcenterApi; module V7; module NotificationService
  class NotificationService < AdsCommon::SavonService
    def initialize(config, endpoint)
      namespace = 'https://adcenter.microsoft.com/api/notifications'
      super(config, endpoint, namespace, :v7)
    end

    def get_notifications(*args, &block)
      return execute_action('get_notifications', args, &block)
    end

    def get_archived_notifications(*args, &block)
      return execute_action('get_archived_notifications', args, &block)
    end

    private

    def get_service_registry()
      return NotificationServiceRegistry
    end

    def get_module()
      return AdcenterApi::V7::NotificationService
    end
  end
end; end; end
