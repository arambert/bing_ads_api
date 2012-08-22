# Handles SOAP headers and namespaces definition for ClientLogin type header.
require 'ads_common/savon_headers/base_header_handler'

module AdcenterApi
  class ClientLoginHeaderHandler < AdsCommon::SavonHeaders::BaseHeaderHandler

    private

    # Generates Adcenter API specific request header with ClientLogin data.
    def generate_request_header()
      request_header = super()
      #puts "--------------- generate_request_header >> request_header >>\n#{request_header}"
      credentials = @credential_handler.credentials
      #puts "--------------- generate_request_header >> credentials >>\n#{credentials}"
      #request_header['authToken'] = @auth_handler.get_token(credentials)
      credentials.each {|k,v| request_header[prepend_namespace(k.to_s.camelize)] = v}
      request_header.select!{|k,_| ['ApplicationToken', 'CustomerAccountId', 'CustomerId', 'DeveloperToken', 'UserName', 'Password'].map{|h| prepend_namespace(h)}.include?(k.to_s)}
      #puts "--------------- generate_request_header >> request_header final >>\n#{request_header}"
      return request_header
    end
  end
end