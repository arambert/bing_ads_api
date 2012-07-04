####### Overriden for Adcenter #########
require 'ads_common/savon_service'

AdsCommon::SavonService.class_eval do
  # Adds namespace to the given string.
  #
  # Args:
  #  - str: String to prepend with a namespace
  #
  # Returns:
  #  - String with a namespace
  #
  def prepend_namespace(str, namespace = AdsCommon::SavonHeaders::BaseHeaderHandler::DEFAULT_NAMESPACE)
    return "%s:%s" % [namespace, str]
  end

  # Executes the SOAP request with original SOAP name.
  def execute_soap_request(action, args, extra_namespaces)
    original_action_name = get_service_registry.get_method_signature(action)[:original_name]
    original_action_name = action if original_action_name.nil?
    ns = AdsCommon::SavonHeaders::BaseHeaderHandler::DEFAULT_NAMESPACE
    args.each do |k,v|
      next if k.to_s=~ /^#{ns}:/
      args[prepend_namespace(k.to_s, ns)] = v
      args.delete(k)
    end
    #puts "[savon_service] execute_soap_request >> @client.inspect=\n#{@client.inspect}\n\n"
    #puts "[savon_service] execute_soap_request >> @client.http.inspect=\n#{@client.http.inspect}\n\n"
    #puts "[savon_service] execute_soap_request >> original_action_name=\n#{original_action_name}\n\n"
    puts "[savon_service] execute_soap_request >> body=\n#{args}\n\n"
    response = @client.request(original_action_name) do |soap|
      soap.body = args
      set_headers(soap, extra_namespaces)
    end
    return response
  end

end