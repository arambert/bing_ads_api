require 'savon'
Savon.configure do |config|
  config.env_namespace = 's'
  config.pretty_print_xml = true
  #config.soap_version = 1
end

client = Savon.client("https://sharedservices-sbx.adcenterapi.microsoft.com/Api/CustomerManagement/v7/CustomerManagementService.svc?wsdl")

response = client.request :get_customer do
  wsdl.element_form_default = :qualified
  #soap.header["tns:ApplicationToken"] = ''
  #soap.header["CustomerAccountId"] = '138537'
  soap.header = { "#{soap.namespace_identifier}:CustomerId" => '8000081',
                  "#{soap.namespace_identifier}:DeveloperToken" => 'K297AX8VPS23',
                  "#{soap.namespace_identifier}:UserName" => 'SB_arambert',
                  "#{soap.namespace_identifier}:Password" => 'Bing1234'}
  #soap.header["Action"] = 'GetCustomersInfo'
  #soap.body = {"CustomerId" => '8000081'}
  soap.body = {"#{soap.namespace_identifier}:CustomerId" => '8000081'}
end

