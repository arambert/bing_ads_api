
class AdsCommonForAdcenter::ParametersValidator < AdsCommon::ParametersValidator

  # Validates input parameters to:
  # - add parameter names;
  # - resolve xsi:type where required;
  # - convert some native types to XML.
  def validate_args(action_name, args)
    in_params = @registry.get_method_signature(action_name)[:input] # Hash like {:name=>"get_accounts_info_request", :fields=>[]}
    # TODO: compare number of parameters.
    args_hash = args#{in_params[:name] => deep_copy(args)}
    #validate_arguments(args_hash, in_params)
    return args_hash
  end

  private

   # Validates given arguments based on provided fields list.
    def validate_arguments(args_hash, fields_list, type_ns = nil)
      check_extra_fields(args_hash, array_from_named_list(fields_list))
      add_order_key(args_hash, fields_list)
      fields_list.each do |field|
        key = field[:name]
        item = args_hash[key]
        check_required_argument_present(item, field)
        if item
          item_type = get_full_type_signature(field[:type])
          item_ns = field[:ns] || type_ns
          key = handle_namespace_override(args_hash, key, item_ns) if item_ns
          validate_arg(item, args_hash, key, item_type)
        end
      end
      return args_hash
    end

end
