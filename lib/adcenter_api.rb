require 'savon'
require 'httpi'
require 'active_support/inflector'

require 'ads_common_for_adcenter'
require 'ads_common_for_adcenter/api_config'
require 'ads_common_for_adcenter/parameters_validator'
require 'ads_common_for_adcenter/auth/client_login_handler'
require 'ads_common_for_adcenter/savon_service'
require 'ads_common_for_adcenter/savon_headers_base_header_handler'
require 'adcenter_api/api_config'
require 'adcenter_api/client_login_header_handler'
require 'adcenter_api/credential_handler'
require 'adcenter_api/errors'
require 'adcenter_api/report_utils'

module AdcenterApi

  # Wrapper class that serves as the main point of access for all the API usage.
  #
  # Holds all the services, as well as login credentials.
  #
  class Api < AdsCommonForAdcenter::Api

    # Constructor for API.
    def initialize(provided_config = nil)
      super(provided_config)
      @credential_handler = AdcenterApi::CredentialHandler.new(@config)
    end

    # Getter for the API service configurations
    def api_config()
      AdcenterApi::ApiConfig
    end

    # Retrieve correct soap_header_handler.
    #
    # Args:
    # - auth_handler: instance of an AdsCommonForAdcenter::Auth::BaseHandler subclass to
    #   handle authentication
    # - version: intended API version
    # - header_ns: header namespace
    # - default_ns: default namespace
    #
    # Returns:
    # - SOAP header handler
    #
    def soap_header_handler(auth_handler, version, header_ns, default_ns)
      auth_method = @config.read('authentication.method', :CLIENTLOGIN)
      handler_class = case auth_method
                      when :CLIENTLOGIN then AdcenterApi::ClientLoginHeaderHandler
                      when :OAUTH, :OAUTH2 then AdsCommonForAdcenter::SavonHeaders::OAuthHeaderHandler
                      end
      return handler_class.new(@credential_handler, auth_handler, header_ns, default_ns, version)
    end

    # Helper method to provide a simple way of doing an MCC-level operation
    # without the need to change credentials. Executes a block of code as an
    # MCC-level operation and/or returns the current status of the property.
    #
    # Args:
    # - accepts a block, which it will execute as an MCC-level operation
    #
    # Returns:
    # - block execution result, if block given
    # - boolean indicating whether MCC-level operations are currently
    #   enabled or disabled, if no block provided
    #
    def use_mcc(&block)
      return (block_given?) ?
        run_with_temporary_flag(:@use_mcc, true, block) :
        @credential_handler.use_mcc
    end

    # Helper method to provide a simple way of doing an MCC-level operation
    # without the need to change credentials. Sets the value of the property
    # that controls whether MCC-level operations are enabled or disabled.
    #
    # Args:
    # - value: the new value for the property (boolean)
    #
    def use_mcc=(value)
      @credential_handler.use_mcc = value
    end

    # Helper method to provide a simple way of doing a validate-only operation
    # without the need to change credentials. Executes a block of code as an
    # validate-only operation and/or returns the current status of the property.
    #
    # Args:
    # - accepts a block, which it will execute as a validate-only operation
    #
    # Returns:
    # - block execution result, if block given
    # - boolean indicating whether validate-only operations are currently
    #   enabled or disabled, if no block provided
    #
    def validate_only(&block)
      return (block_given?) ?
        run_with_temporary_flag(:@validate_only, true, block) :
        @credential_handler.validate_only
    end

    # Helper method to provide a simple way of performing validate-only
    # operations. Sets the value of the property
    # that controls whether validate-only operations are enabled or disabled.
    #
    # Args:
    # - value: the new value for the property (boolean)
    #
    def validate_only=(value)
      @credential_handler.validate_only = value
    end

    # Helper method to provide a simple way of performing requests with support
    # for partial failures. Executes a block of code with partial failures
    # enabled and/or returns the current status of the property.
    #
    # Args:
    # - accepts a block, which it will execute as a partial failure operation
    #
    # Returns:
    # - block execution result, if block given
    # - boolean indicating whether partial failure operations are currently
    # enabled or disabled, if no block provided
    #
    def partial_failure(&block)
      return (block_given?) ?
        run_with_temporary_flag(:@partial_failure, true, block) :
        @credential_handler.partial_failure
    end

    # Helper method to provide a simple way of performing requests with support
    # for partial failures.
    #
    # Args:
    # - value: the new value for the property (boolean)
    #
    def partial_failure=(value)
      @credential_handler.partial_failure = value
    end

    # Returns an instance of ReportUtils object with all utilities relevant to
    # the reporting.
    #
    # Args:
    # - version: version of the API to use (optional).
    #
    def report_utils(version = nil)
      version = api_config.default_version if version.nil?
      # Check if version exists.
      if !api_config.versions.include?(version)
        raise AdsCommonForAdcenter::Errors::Error, "Unknown version '%s'" % version
      end
      return AdcenterApi::ReportUtils.new(self, version)
    end

    private

    # Executes block with a temporary flag set to a given value. Returns block
    # result.
    def run_with_temporary_flag(flag_name, flag_value, block)
      previous = @credential_handler.instance_variable_get(flag_name)
      @credential_handler.instance_variable_set(flag_name, flag_value)
      begin
        return block.call
      ensure
        @credential_handler.instance_variable_set(flag_name, previous)
      end
    end

  end


end