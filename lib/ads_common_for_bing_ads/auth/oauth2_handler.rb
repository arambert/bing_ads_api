####### Overriden for Bing Ads #########
module AdsCommonForBingAds
  module Auth

    class OAuth2Handler

      OAUTH2_CONFIG_BING = {
          :authorization_uri =>
              'https://login.live.com/oauth20_authorize.srf',
          :token_credential_uri =>
              'https://login.live.com/oauth20_token.srf'
      }

      def auth_string(credentials)
        token = get_token(credentials)
        token[:access_token]
      end

      private

      def create_client(credentials)
        oauth_options_bing = OAUTH2_CONFIG_BING.merge({
                                                          :client_id => credentials[:oauth2_client_id],
                                                          :client_secret => credentials[:oauth2_client_secret],
                                                          :scope => @scope,
                                                          :redirect_uri => credentials[:oauth2_callback] || DEFAULT_CALLBACK,
                                                          :state => credentials[:oauth2_state]
                                                      }).reject {|k, v| v.nil?}
        return Signet::OAuth2::Client.new(oauth_options_bing)
      end
    end
  end
end
