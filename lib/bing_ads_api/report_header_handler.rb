# Handles HTTP headers for AdHoc reporting requests.

module BingAdsApi
  class ReportHeaderHandler

    # Initializes a header handler.
    #
    # Args:
    #  - credential_handler: a header with credential data
    #  - auth_handler: a header with auth data
    #  - config: API config
    #
    def initialize(credential_handler, auth_handler, config)
      @credential_handler = credential_handler
      @auth_handler = auth_handler
      @config = config
    end

    # Returns the headers set for the report request.
    #
    # Args:
    #  - url: URL for the report requests
    #  - cid: clientCustomerId to use
    #
    # Returns:
    #  - a Hash with HTTP headers.
    #
    def headers(url, cid)
      override = (cid.nil?) ? nil : {:client_customer_id => cid}
      credentials = @credential_handler.credentials(override)
      headers = {
          'Content-Type' => 'application/x-www-form-urlencoded',
          'Authorization' =>
              @auth_handler.auth_string(credentials, HTTPI::Request.new(url)),
          'User-Agent' => @credential_handler.generate_user_agent(),
          'clientCustomerId' => credentials[:client_customer_id].to_s,
          'developerToken' => credentials[:developer_token]
      }
      money_in_micros = @config.read('library.return_money_in_micros')
      unless money_in_micros.nil?
        headers['returnMoneyInMicros'] = money_in_micros
      end
      return headers
    end
  end
end