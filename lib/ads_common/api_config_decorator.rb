####### Overriden for Adcenter #########

AdsCommon::ApiConfig.module_eval do

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

end