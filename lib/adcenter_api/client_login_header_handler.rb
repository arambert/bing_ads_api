# Handles SOAP headers and namespaces definition for ClientLogin type header.
require 'ads_common/savon_headers/base_header_handler'

module AdcenterApi
  class ClientLoginHeaderHandler < AdsCommon::SavonHeaders::BaseHeaderHandler
    # Initializes a header handler.
    #
    # Args:
    #  - credential_handler: a header with credential data
    #  - auth_handler: a header with auth data
    #  - element_name: an API-specific name of header element
    #  - namespace: default namespace to use
    #  - auth_namespace: namespace to use for auth headers
    #  - version: services version
    #
    #def initialize(credential_handler, auth_handler, namespace, auth_namespace, version)
    def initialize(credential_handler, auth_handler, namespace, version)
      super(credential_handler, auth_handler, namespace, version)
      #@auth_namespace = auth_namespace
    end

    # Enriches soap object with API-specific headers like namespaces, login
    # credentials etc. Sets the default namespace for the body to the one
    # specified in initializer.
    #
    # Args:
    #  - request: a HTTPI Request for extra configuration (unused)
    #  - soap: a Savon soap object to fill fields in
    #
    # Returns:
    #  - modified soap structure
    #
    def prepare_request(request, soap)
      super(request, soap)
      soap.header[:attributes!] ||= {}
      header_name = prepend_namespace(get_header_element_name())
      soap.header[:attributes!][header_name] ||= {}
      #soap.header[:attributes!][header_name]['xmlns'] = @auth_namespace
      return soap
    end

    private
    # Skips namespace prefixes for all elements except top level. Use default
    # (inherited) prefixing for the top level key.
    #
    # Args:
    #  - str: String to prepend with a namespace
    #
    # Returns:
    #  - String with a namespace
    #
    def prepend_namespace(str)
      return get_header_element_name().eql?(str) ? super(str) : str
    end

    # Generates Adcenter API specific request header with ClientLogin data.
    def generate_request_header()
      request_header = super()
      credentials = @credential_handler.credentials
      request_header['authToken'] = @auth_handler.get_token(credentials)
      return request_header
    end
  end
end