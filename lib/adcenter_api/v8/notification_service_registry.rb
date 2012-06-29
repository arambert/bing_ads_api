# Encoding: utf-8
require 'adcenter_api/errors'

module AdcenterApi; module V8; module NotificationService
  class NotificationServiceRegistry
    NOTIFICATIONSERVICE_METHODS = {:get_notifications=>{:input=>[], :output=>{:name=>"get_notifications_response", :fields=>[]}, :original_name=>"GetNotifications"}, :get_archived_notifications=>{:input=>[], :output=>{:name=>"get_archived_notifications_response", :fields=>[]}, :original_name=>"GetArchivedNotifications"}}
    NOTIFICATIONSERVICE_TYPES = {}
    NOTIFICATIONSERVICE_NAMESPACES = []

    def self.get_method_signature(method_name)
      return NOTIFICATIONSERVICE_METHODS[method_name.to_sym]
    end

    def self.get_type_signature(type_name)
      return NOTIFICATIONSERVICE_TYPES[type_name.to_sym]
    end

    def self.get_namespace(index)
      return NOTIFICATIONSERVICE_NAMESPACES[index]
    end
  end
end; end; end
