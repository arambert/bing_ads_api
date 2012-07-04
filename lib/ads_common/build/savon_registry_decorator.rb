require 'ads_common/build/savon_registry'

AdsCommon::Build::SavonRegistry.class_eval do

  # Extracts input parameters of given method as an array.
  def extract_input_parameters(op_node, doc)
    input_element = REXML::XPath.first(op_node, 'descendant::wsdl:input')
    input_name = get_element_name(input_element)
    input_fields = find_sequence_fields(input_name, doc)
    return {:name => input_name.snakecase, :fields => input_fields}
  end




end
