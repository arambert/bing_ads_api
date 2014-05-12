Bing Ads Api Client
=============

Description
-------------
A simple ruby wrapper for the Bing Ads API based on the gem "google-ads-common".

Usage
-------------

    # install in your gem file
    gem 'bing_ads_api', :git => 'https://github.com/arambert/bing_ads_api.git'

    # initialize the client
    client = BingAdsApi::Api.new(
            {
              :authentication => {
                :method => 'ClientLogin',
                :developer_token => 'DEVELOPER_TOKEN',
                :user_name => 'USERNAME',
                :password => 'PASSWORD',
                :customer_id => 'customer_id', # may be optional for some requests
                :customer_account_id => 'customer_account_id' # may be optional for some requests
              },
              :service => {:environment => 'PRODUCTION'},
              :library => {:log_level => 'DEBUG'}
            })

    # select the service and the API version (:v8 or :v9)
    administration_service = client.service(:AdministrationService, :v9)

    # send your request
    result = administration_service.get_assigned_quota()

    # select another service
    campaign_service = client.service(:CampaignManagementService, :v9)

    # send another request
    result = campaign_service.get_campaigns_by_account_id({:account_id => 00000})

    # create a campaign
    result2 = campaign_service.add_campaigns({:account_id => 00000,
                                            :campaigns => {:campaign => [{:budget_type => "DailyBudgetWithMaximumMonthlySpend",
                                                                          :conversion_tracking_enabled => false,
                                                                          :daily_budget => 5,
                                                                          :daylight_saving => false,
                                                                          :description => "A perfect new campaign",
                                                                          :monthly_budget => 50,
                                                                          :name => "perfectcampaign",
                                                                          :time_zone => "BrusselsCopenhagenMadridParis"}]
                                                          }
                                            })

About the gem
-------------
The tests still have to be written.
Any help is welcome !
