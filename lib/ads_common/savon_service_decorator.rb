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

  # Finds an exception object for a given response.
  def exception_for_soap_fault(response)
    begin
      fault = response[:fault]
      if fault[:detail] and fault[:detail][:api_exception_fault]
        exception_fault = fault[:detail][:api_exception_fault]
        exception_name = exception_fault[:application_exception_type]
        exception_class = get_module().const_get(exception_name)
        return exception_class.new(exception_fault)
      # Specific to AdCenter
      elsif fault[:detail] and fault[:detail][:api_fault]
        operation_error = fault[:detail][:api_fault][:operation_errors][:operation_error]
        if exception_name = AdcenterApi::Errors::CODES[operation_error[:code]]
          exception_class = AdcenterApi::Errors.const_get(exception_name)
        else
          raise Exception.new("code #{operation_error[:code]}")
        end
        return exception_class.new("#{operation_error[:message]} (#{operation_error[:details]})")
      elsif fault[:faultstring]
        fault_message = fault[:faultstring]
        return AdsCommon::Errors::ApiException.new(
            "Unknown exception with error: %s" % fault_message)
      else
        raise ArgumentError.new(fault.to_s)
      end
    rescue Exception => e
      operation_error ||= response[:fault][:detail][:api_fault][:operation_errors][:operation_error] rescue {}
      return AdsCommon::Errors::ApiException.new(
          "Failed to resolve exception (%s), details: %s, SOAP fault: %s" %
          [e.message, "#{operation_error[:message]} (#{operation_error[:details]})", response.soap_fault])
    end
  end


end