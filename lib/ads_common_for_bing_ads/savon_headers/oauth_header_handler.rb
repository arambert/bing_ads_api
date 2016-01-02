module AdsCommonForBingAds
  module SavonHeaders

    class OAuthHeaderHandler

      private

      # Generates SOAP request header with login credentials and namespace
      # definition for OAuth authentication.
      #
      # Args:
      #  - request: a HTTPI Request to generate headers for
      #  - soap: a Savon soap object to fill fields in
      #
      # Returns:
      #  - Hash containing a header with filled in credentials
      #
      def generate_headers(request, soap)
        #super(request, soap)
        credentials = @credential_handler.credentials

        request.url = soap.endpoint

        soap.header['wsdl:AuthenticationToken'] =  @auth_handler.auth_string(credentials)
        soap.header['wsdl:DeveloperToken'] =  credentials[:developer_token]
        soap.header['wsdl:CustomerAccountId'] =  credentials[:customer_account_id]

      end
    end
  end
end
