# encoding: utf-8
# Helper methods for loading and managing the available services in the AdCenter API.

require 'ads_common/api_config'

require 'adcenter_api/version'

module AdcenterApi

  # Contains helper methods for loading and managing the available services.
  module ApiConfig

    # Inherit from AdsCommon::ApiConfig
    class << ApiConfig
      include AdsCommon::ApiConfig
    end

    # Set defaults
    DEFAULT_VERSION = :v8
    DEFAULT_ENVIRONMENT = :PRODUCTION
    LATEST_VERSION = :v8

    # Set other constants
    API_NAME = 'AdcenterApi'
    DEFAULT_CONFIG_FILENAME = 'adcenter_api.yml'

    # Configure the services available to each version
    @@service_config = {
      :v7 => [
          :AdministrationService,
          :CampaignManagementService,
          :CustomerBillingService,
          :CustomerManagementService,
          :NotificationService,
          :ReportingService
            ],
      :v8 => [
          :AdIntelligenceService,
          :AdministrationService,
          :BulkService,
          :CampaignManagementService,
          :CustomerBillingService,
          :CustomerManagementService,
          :NotificationService,
          :OptimizerService,
          :ReportingService
      ]
    }

    ## Configure the different environments, with the base URL for each one
    #@@environment_config = {
    #  :PRODUCTION => {
    #    :oauth_scope => 'https://adwords.google.com/api/adwords/',
    #    :v7 => 'https://adwords.google.com/api/adwords/',
    #    :v8 => 'https://adwords.google.com/api/adwords/'
    #  },
    #  :SANDBOX => {
    #    :oauth_scope => 'https://adwords-sandbox.google.com/api/adwords/',
    #    :v7 => 'https://adwords-sandbox.google.com/api/adwords/',
    #    :v8 => 'https://adwords-sandbox.google.com/api/adwords/'
    #  }
    #}

    # Configure the subdirectories for each version / service pair.
    # A missing pair means that only the base URL is used.
    @@address_config = {
      :v8 => {
        :AdIntelligenceService     => {:PRODUCTION => "https://adcenterapi.microsoft.com/Api/Advertiser/v8/CampaignManagement/AdIntelligenceService.svc?wsdl", :SANDBOX => ""},
        :AdministrationService     => {:PRODUCTION => "https://adcenterapi.microsoft.com/Api/Advertiser/v8/Administration/AdministrationService.svc?wsdl",     :SANDBOX => ""},
        :BulkService               => {:PRODUCTION => "https://adcenterapi.microsoft.com/Api/Advertiser/v8/CampaignManagement/BulkService.svc?wsdl",           :SANDBOX => ""},
        :CampaignManagementService => {:PRODUCTION => "https://adcenterapi.microsoft.com/Api/Advertiser/v8/CampaignManagement/CampaignManagementService.svc?wsdl", :SANDBOX => ""},
        :CustomerBillingService    => {:PRODUCTION => "https://sharedservices.adcenterapi.microsoft.com/Api/Billing/v8/CustomerBillingService.svc?wsdl",       :SANDBOX => ""},
        :CustomerManagementService => {:PRODUCTION => "https://sharedservices.adcenterapi.microsoft.com/Api/CustomerManagement/v8/CustomerManagementService.svc?wsdl", :SANDBOX => ""},
        :NotificationService       => {:PRODUCTION => "https://sharedservices.adcenterapi.microsoft.com/Api/Notification/v8/NotificationService.svc?wsdl",     :SANDBOX => ""},
        :OptimizerService          => {:PRODUCTION => "https://adcenterapi.microsoft.com/Api/Advertiser/v8/Optimizer/OptimizerService.svc?wsdl",               :SANDBOX => ""},
        :ReportingService          => {:PRODUCTION => "https://adcenterapi.microsoft.com/Api/Advertiser/v8/Reporting/ReportingService.svc?wsdl",               :SANDBOX => ""}
      },
      :v7 => {
        :AdministrationService     => {:PRODUCTION => "https://adcenterapi.microsoft.com/Api/Advertiser/v7/Administration/AdministrationService.svc?wsdl",           :SANDBOX => "https://sandboxapi.adcenter.microsoft.com/Api/Advertiser/v7/Administration/AdministrationService.svc?wsdl"},
        :CampaignManagementService => {:PRODUCTION => "https://adcenterapi.microsoft.com/Api/Advertiser/v7/CampaignManagement/CampaignManagementService.svc?wsdl",   :SANDBOX => "https://sandboxapi.adcenter.microsoft.com/Api/Advertiser/v7/CampaignManagement/CampaignManagementService.svc?wsdl"},
        :CustomerBillingService    => {:PRODUCTION => "https://sharedservices.adcenterapi.microsoft.com/Api/Billing/v7/CustomerBillingService.svc?wsdl",             :SANDBOX => "https://sharedservices-sbx.adcenterapi.microsoft.com/Api/Billing/v7/CustomerBillingService.svc?wsdl"},
        :CustomerManagementService => {:PRODUCTION => "https://sharedservices.adcenterapi.microsoft.com/Api/CustomerManagement/v7/CustomerManagementService.svc?wsdl", :SANDBOX => "https://sharedservices-sbx.adcenterapi.microsoft.com/Api/CustomerManagement/v7/CustomerManagementService.svc?wsdl"},
        :NotificationService       => {:PRODUCTION => "https://sharedservices.adcenterapi.microsoft.com/Api/Notification/v8/NotificationService.svc?wsdl",           :SANDBOX => ""},
        :ReportingService          => {:PRODUCTION => "https://adcenterapi.microsoft.com/Api/Advertiser/v7/Reporting/ReportingService.svc?wsdl",                     :SANDBOX => "https://sandboxapi.adcenter.microsoft.com/Api/Advertiser/v7/Reporting/ReportingService.svc?wsdl"}
      }
    }

    # Auth constants for ClientLogin method.
    @@client_login_config = {
      :AUTH_SERVER => 'https://www.google.com',
      :AUTH_NAMESPACE_PREAMBLE =>
          'https://adwords.google.com/api/adwords/cm/',
      :LOGIN_SERVICE_NAME => 'adwords'
    }

    public

    ####### Overriden for Adcenter #########
    # Get the endpoint for a service on a given environment and API version.
    #
    # Args:
    # - environment: the service environment to be used
    # - version: the API version
    # - service: the name of the API service
    #
    # Returns:
    # The endpoint URL
    #
    def endpoint(environment, version, service)
      if !address_config().nil?
        address_config()[version][service][environment].to_s
      else
        ""
      end
    end
    # Generates an array of WSDL URLs based on defined Services and version
    # supplied. This method is used by generators to determine what service
    # wrappers to generate.
    #
    # Args:
    #   - version: the API version.
    #
    # Returns
    #   hash of pairs Service => WSDL URL
    #
    def get_wsdls(version)
      res = {}
      services(version).each do |service|
        if (!address_config().nil?)
          path = address_config()[version][service][default_environment()].to_s
        end
        res[service.to_s] = path || ""
      end
      return res
    end
    ########################################
    # Getters for constants and module variables.
    def self.default_version
      DEFAULT_VERSION
    end

    def self.default_environment
      DEFAULT_ENVIRONMENT
    end

    def self.latest_version
      LATEST_VERSION
    end

    def self.api_name
      API_NAME
    end

    def self.service_config
      @@service_config
    end

    #def self.environment_config(environment, key)
    #  return @@environment_config.include?(environment) ?
    #      @@environment_config[environment][key] : nil
    #end
    #
    def self.address_config
      @@address_config
    end

    def self.client_login_config(key)
      return @@client_login_config[key]
    end

    def self.default_config_filename
      DEFAULT_CONFIG_FILENAME
    end

    def self.headers_config
      @@headers_config
    end

    # Get the download URL for Ad Hoc reports.
    #
    # Args:
    # - environment: the service environment to be used
    # - version: the API version (as a symbol)
    #
    # Returns:
    # - The endpoint URL (as a string)
    #
    def self.adhoc_report_download_url(environment, version)
      base = get_wsdl_base(environment, version)
      if base
        base += 'reportdownload/%s' % version.to_s
      end
      return base
    end
  end
end