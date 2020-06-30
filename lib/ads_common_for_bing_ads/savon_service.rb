####### Overriden for Bing Ads #########

class AdsCommonForBingAds::SavonService < AdsCommon::SavonService

  private

  # [CHANGES: 
  # => ParametersValidator to AdsCommonForBingAds::ParametersValidator
  # => ResultsExtractor    to AdsCommon::ResultsExtractor]
  # Executes SOAP action specified as a string with given arguments.
    def execute_action(action_name, args, &block)
      registry = get_service_registry()
      validator = AdsCommonForBingAds::ParametersValidator.new(registry)
      args = validator.validate_args(action_name, args)
      response = execute_soap_request(
          action_name.to_sym, args, validator.extra_namespaces)
      log_headers(response.http.headers)
      handle_errors(response)
      extractor = AdsCommon::ResultsExtractor.new(registry)
      result = extractor.extract_result(response, action_name, &block)
      run_user_block(extractor, response, result, &block) if block_given?
      return result
    end

  # Adds namespace to the given string.
  #
  # Args:
  #  - str: String to prepend with a namespace
  #
  # Returns:
  #  - String with a namespace
  #
  def prepend_namespace(str, namespace = AdsCommonForBingAds::SavonHeaders::BaseHeaderHandler::DEFAULT_NAMESPACE)
    return "%s:%s" % [namespace, str]
  end

  # Executes the SOAP request with original SOAP name.
  def execute_soap_request(action, args, extra_namespaces)
    ns = AdsCommonForBingAds::SavonHeaders::BaseHeaderHandler::DEFAULT_NAMESPACE
    original_input_name = get_service_registry.get_method_signature(action)[:input][:name].to_s.camelize
    original_action_name = get_service_registry.get_method_signature(action)[:original_name].to_s.camelize
    original_action_name = action if original_action_name.nil?
    args = args.first if args.is_a?(Array)
    additional_headers = args.delete(:headers) unless args.nil?
    prepend_namespace_to_hash(args, ns)
    prepend_namespace_to_hash(additional_headers, ns)
    puts "**************************************args = #{args}"
    response = @client.request(ns, original_input_name) do |soap, wsdl, http|
      http.headers["SOAPAction"] = %{"#{original_action_name}"}
      soap.body = args
      header_handler.prepare_request(http, soap)
      soap.namespaces.merge!(extra_namespaces) unless extra_namespaces.nil?
    end
    return response
  end
  

  def prepend_namespace_to_hash h, namespace
    if h.is_a?(Hash)
      h.dup.each do |k,v|
        h.delete(k)
        if k.to_s=~/!$/ || k.to_s=~/:/ #on ne transforme pas les noms finissant par ! ou contenant : (exemple: attributes! ou xsi:type)
          h[k] = prepend_namespace_to_hash(v, namespace)
        else
          h[k.to_s=~ /^#{namespace}:/ ? k : prepend_namespace((k.class == Symbol ? k.to_s.camelize : k.to_s), namespace)] = prepend_namespace_to_hash(v, namespace)
        end
      end
    elsif h.is_a?(Array) # e.g: h = {:campaigns => {:campaign => [{:name => 'foo'}, {:name => 'foofoo'}]}}
      h.map!{|e| prepend_namespace_to_hash(e, namespace)}
    end
    return h
  end

  # Creates and sets up Savon client.
  def create_savon_client(endpoint, namespace)
    Nori.advanced_typecasting = false
    client = Savon::Client.new do |wsdl, httpi|
      wsdl.endpoint = endpoint
      wsdl.namespace = namespace
      wsdl.element_form_default = :qualified
      AdsCommonForBingAds::Http.configure_httpi(@config, httpi)
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
      # Specific to Bing Ads
      elsif fault[:detail] and fault[:detail][:api_fault]
        operation_error = fault[:detail][:api_fault][:operation_errors][:operation_error]
        operation_error = operation_error.first if operation_error.is_a?(Array) # if we get several errors, we only raise the first one
        if exception_name = BingAdsApi::Errors::CODES[operation_error[:code]]
          exception_class = BingAdsApi::Errors.const_get(exception_name)
        else
          raise Exception.new("code #{operation_error[:code]}")
        end
        return exception_class.new("#{operation_error[:message]} (#{operation_error[:details]})")
      # Specific to Bing Ads (batches)
      elsif fault[:detail] and fault[:detail][:api_fault_detail]
        operation_error = fault[:detail][:api_fault_detail][:batch_errors][:batch_error]
        operation_error = operation_error.first if operation_error.is_a?(Array) # if we get several errors, we only raise the first one
        if exception_name = BingAdsApi::Errors::CODES[operation_error[:code]]
          exception_class = BingAdsApi::Errors.const_get(exception_name)
        else
          raise Exception.new("code #{operation_error[:code]}")
        end
        return exception_class.new("#{operation_error[:message]} (#{operation_error[:details]})")
      # Specific to Bing Ads (ad api)
      elsif fault[:detail] and fault[:detail][:ad_api_fault_detail]
        operation_error = fault[:detail][:ad_api_fault_detail][:errors][:ad_api_error]
        operation_error = operation_error.first if operation_error.is_a?(Array) # if we get several errors, we only raise the first one
        if exception_name = BingAdsApi::Errors::CODES[operation_error[:code]]
          exception_class = BingAdsApi::Errors.const_get(exception_name)
        else
          raise Exception.new("code #{operation_error[:code]}")
        end
        return exception_class.new("#{operation_error[:message]} (#{operation_error[:details]})")
      elsif fault[:faultstring]
        fault_message = fault[:faultstring]
        return AdsCommonForBingAds::Errors::ApiException.new(
            "Unknown exception with error: %s" % fault_message)
      else
        raise ArgumentError.new(fault.to_s)
      end
    rescue Exception => e
      operation_error ||= response[:fault][:detail][:api_fault][:operation_errors][:operation_error] rescue {}
      return AdsCommonForBingAds::Errors::ApiException.new(
          "Failed to resolve exception (%s), details: %s, SOAP fault: %s" %
          [e.message, "#{operation_error[:message]} (#{operation_error[:details]})", response.soap_fault])
    end
  end


end
