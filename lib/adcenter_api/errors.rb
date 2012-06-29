# Specific error handling for the Adcenter API.

require 'ads_common/errors'

module AdcenterApi
  module Errors

    # This class encapsulates base class for API exceptions. More specific
    # exceptions are generated based on Service WSDL.
    class ApiException < AdsCommon::Errors::ApiException
      attr_reader :array_fields

      def initialize(exception_fault)
        @array_fields ||= []
        exception_fault.each { |key, value| set_field(key, value) }
      end

      private

      # Sets instance's property to a value if it is defined
      def set_field(field, value)
        if respond_to?(field)
          value = arrayize(value) if is_array_field(field)
          instance_variable_set("@#{field}", value)
        end
      end

      # Makes sure object is an array
      def arrayize(object)
        return [] if object.nil?
        return object.is_a?(Array) ? object : [object]
      end

      # Should a field be forced to be an array
      def is_array_field(field)
        return @array_fields.include?(field.to_s)
      end
    end

    # Error for invalid credentials sush as malformed ID.
    class BadCredentialsError < AdsCommon::Errors::ApiException
    end

    # Error for malformed report definition.
    class InvalidReportDefinitionError < AdsCommon::Errors::ApiException
    end

    # Error for server-side report error.
    class ReportError < AdsCommon::Errors::ApiException
      attr_reader :http_code

      def initialize(http_code, message)
        super(message)
        @http_code = http_code
      end
    end
  end
end