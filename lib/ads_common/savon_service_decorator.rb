####### Overriden for Adcenter #########
require 'ads_common/savon_service'

AdsCommon::SavonService.class_eval do

  private

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
    ns = AdsCommon::SavonHeaders::BaseHeaderHandler::DEFAULT_NAMESPACE
    original_input_name = get_service_registry.get_method_signature(action)[:input][:name].to_s.camelize
    original_action_name = get_service_registry.get_method_signature(action)[:original_name].to_s.camelize
    original_action_name = action if original_action_name.nil?
    args = args.first if args.is_a?(Array)
    args.dup.each do |k,v|
      next if k.to_s=~ /^#{ns}:/
      args[prepend_namespace(k.to_s.camelize, ns)] = v
      args.delete(k)
    end
    response = @client.request(ns, original_input_name) do |soap|
      soap.body = args
      set_headers(soap, extra_namespaces)
      @client.http.headers["SOAPAction"] = original_action_name
    end
    return response
  end

  # Creates and sets up Savon client.
  def create_savon_client(endpoint, namespace)
    Nori.advanced_typecasting = false
    client = Savon::Client.new do |wsdl, httpi|
      wsdl.endpoint = endpoint
      wsdl.namespace = namespace
      wsdl.element_form_default = :qualified
      AdsCommon::Http.configure_httpi(@config, httpi)
    end
    client.config.raise_errors = false
    client.config.logger.subject = get_logger()
    return client
  end

end