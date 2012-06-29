require 'spec_helper'

describe AdcenterApi do
  it "comes from a module" do #simple test to init tests
    AdcenterApi.should be_a_kind_of(Module)
  end
end

describe AdcenterApi, "connect" do
  before(:all) do #once (and could be modified by the following tests)

  end
  it "authenticates" do
    lambda{
      $adcenter = AdcenterApi::Api.new({
         :authentication => {
             :method => 'ClientLogin',
             :developer_token => 'DEVELOPER_TOKEN',
             :user_agent => 'Ruby Sample',
             :password => 'PASSWORD',
             :email => 'user@domain.com',
             :client_customer_id => '012-345-6789'
         },
         :service => {
           :environment => 'PRODUCTION'
         }
       })
    }.should_not raise_error
  end

  it "selects a service" do
    lambda{ $customer_srv = $adcenter.service(:CustomerManagementService, :v8)}.should_not raise_error
  end
  it "selects a service" do
    lambda{ customer_infos = $customer_srv.get({:fields => ['Id', 'Name', 'Status']})}.should_not raise_error
  end

end