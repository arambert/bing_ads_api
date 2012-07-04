####### Overriden for Adcenter #########
require 'ads_common/savon_headers/base_header_handler'

AdsCommon::SavonHeaders::BaseHeaderHandler.class_eval do

  # Generates SOAP headers with the default request header element.
  def generate_headers(request, soap)
    soap.header.merge!(generate_request_header())
  end
  # Generates SOAP default request header with all requested headers.
  #def generate_request_header()
  #  credentials = @credential_handler.credentials
  #  extra_headers = credentials[:extra_headers]
  #  puts "extra_headers=#{extra_headers}"
  #  return extra_headers.inject({}) do |result, (header, value)|
  #    puts "header=#{header}"
  #    puts "value=#{value}"
  #    result[prepend_namespace(header)] = value
  #    result
  #  end
  #end

end