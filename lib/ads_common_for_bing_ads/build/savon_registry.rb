module AdsCommonForBingAds
  module Build

    class SavonRegistry

      # Extracts input parameters of given method as an array.
      def extract_input_parameters(op_node, doc)
        input_element = REXML::XPath.first(op_node, 'descendant::wsdl:input')
        input_name = get_element_name(input_element)
        input_fields = find_sequence_fields(input_name, doc)
        return {:name => input_name.snakecase, :fields => input_fields}
      end

    end

  end
end
