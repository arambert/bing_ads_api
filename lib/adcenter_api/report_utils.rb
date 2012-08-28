# Contains utility methods specific to reporting.

require 'cgi'
require 'gyoku'

require 'adcenter_api/errors'
require 'adcenter_api/report_header_handler'

module AdcenterApi
  class ReportUtils
    # Default constructor.
    #
    # Args:
    # - api: AdcenterApi object
    # - version: API version to use
    #
    def initialize(api, version)
      @api, @version = api, version
    end

    # Downloads and returns a report.
    #
    # Args:
    # - report_definition: definition of the report in XML text or hash
    # - cid: optional customer ID to run against
    #
    # Returns:
    # - report body
    #
    # Raises:
    # - AdcenterApi::Errors::InvalidReportDefinitionError if the report
    #   definition is invalid
    # - AdcenterApi::Errors::ReportError if server-side error occurred
    #
    def download_report(report_definition, cid = nil)
      return get_report_response(report_definition, cid).body
    end

    # Downloads a report and saves it to a file.
    #
    # Args:
    # - report_definition: definition of the report in XML text or hash
    # - path: path to save report to
    # - cid: optional customer ID to run against
    #
    # Returns:
    # - nil
    #
    # Raises:
    # - AdcenterApi::Errors::InvalidReportDefinitionError if the report
    #   definition is invalid
    # - AdcenterApi::Errors::ReportError if server-side error occurred
    #
    def download_report_as_file(report_definition, path, cid = nil)
      report_body = download_report(report_definition, cid)
      save_to_file(report_body, path)
      return nil
    end

    private

    # Minimal set of required fields for report definition.
    REQUIRED_FIELDS = [:selector, :report_name, :report_type, :date_range_type]

    # Definition fields have to be in particular order in the XML. Here is its
    # specification.
    REPORT_DEFINITION_ORDER = {
      :root => [:selector, :report_name, :report_type, :date_range_type,
          :download_format, :include_zero_impressions],
      :selector => [:fields, :predicates, :date_range, :ordering, :paging],
      :predicates => [:field, :operator, :values],
      :ordering => [:field, :sort_order],
      :paging => [:start_index, :number_results],
      :date_range => [:min, :max]
    }

    # Send POST request for a report and returns Response object.
    def get_report_response(report_definition, cid)
      definition_text = get_report_definition_text(report_definition)
      data = '__rdxml=%s' % CGI.escape(definition_text)
      url = @api.api_config.adhoc_report_download_url(
          @api.config.read('service.environment'), @version)
      headers = get_report_request_headers(url, cid)
      log_request(url, headers, definition_text)
      response = AdsCommonForAdcenter::Http.post_response(url, data, @api.config, headers)
      check_for_errors(response)
      return response
    end

    # Converts passed object to XML text. Currently support String (no changes)
    # and Hash (renders XML).
    def get_report_definition_text(report_definition)
      return case report_definition
        when String then report_definition
        when Hash then report_definition_to_xml(report_definition)
        else
          raise AdcenterApi::Errors::InvalidReportDefinitionError,
              'Unknown object for report definition: %s' %
              report_definition.class
      end
    end

    # Prepares headers for report request.
    def get_report_request_headers(url, cid)
      @header_handler ||= AdcenterApi::ReportHeaderHandler.new(
          @api.credential_handler, @api.get_auth_handler(), @api.config)
      return @header_handler.headers(url, cid)
    end

    # Saves raw data to a file.
    def save_to_file(data, path)
      open(path, 'wb') { |file| file.write(data) } if path
    end

    # Logs the request on debug level.
    def log_request(url, headers, body)
      logger = @api.logger
      logger.debug("Report request to: '%s'" % url)
      logger.debug('HTTP headers: [%s]' %
          (headers.map { |k, v| [k, v].join(': ') }.join(', ')))
      logger.debug(body)
    end

    # Checks downloaded data for error signature. Raises ReportError if it
    # detects an error.
    def check_for_errors(response)
      # Check for error in body.
      report_body = response.body
      if report_body and
          ((RUBY_VERSION < '1.9.1') or report_body.valid_encoding?)
        error_message_regex = '^!!!(-?\d+)\|\|\|(-?\d+)\|\|\|(.*)\?\?\?'
        data = report_body.slice(0, 1024)
        matches = data.match(error_message_regex)
        if matches
          message = (matches[3].nil?) ? data : matches[3]
          raise AdcenterApi::Errors::ReportError.new(response.code,
              'Report download error occured: %s' % message)
        end
      end
      # Check for error code.
      unless response.code == 200
        raise AdcenterApi::Errors::ReportError.new(response.code,
            'Report download error occured, http code: %d, body: %s' %
            [response.code, response.body])
      end
      return nil
    end

    # Renders a report definition hash into XML text.
    def report_definition_to_xml(report_definition)
      check_report_definition_hash(report_definition)
      add_report_definition_hash_order(report_definition)
      return Gyoku.xml({:report_definition => report_definition})
    end

    # Checks if the report definition looks correct.
    def check_report_definition_hash(report_definition)
      # Minimal set of fields required.
      REQUIRED_FIELDS.each do |field|
        unless report_definition.include?(field)
          raise AdcenterApi::Errors::InvalidReportDefinitionError,
              "Required field '%s' is missing in the definition" % field
        end
      end
      # Fields list is also required.
      unless report_definition[:selector].include?(:fields)
        raise AdcenterApi::Errors::InvalidReportDefinitionError,
            'Fields list is required'
      end
      # 'Fields' must be an Array.
      unless report_definition[:selector][:fields].kind_of?(Array)
        raise AdcenterApi::Errors::InvalidReportDefinitionError,
            'Fields list must be an array'
      end
      # We should request at least one field.
      if report_definition[:selector][:fields].empty?
        raise AdcenterApi::Errors::InvalidReportDefinitionError,
            'At least one field needs to be requested'
      end
    end

    # Adds fields order hint to generator based on specification.
    def add_report_definition_hash_order(node, name = :root)
      def_order = REPORT_DEFINITION_ORDER[name]
      var_order = def_order.reject { |field| !node.include?(field) }
      node.keys.each do |key|
        if REPORT_DEFINITION_ORDER.include?(key)
          case node[key]
            when Hash
              add_report_definition_hash_order(node[key], key)
            when Array
              node[key].each do |item|
                add_report_definition_hash_order(item, key)
              end
          end
        end
      end
      node[:order!] = var_order
      return nil
    end
  end
end