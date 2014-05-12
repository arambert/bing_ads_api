module AdsCommonForBingAds
  module Build

    class SavonGenerator

      private

      # Generates registry file.
      def write_registry(wsdl, file_name)
        registry_file = create_new_file(file_name)
        generator = SavonRegistryGenerator.new(@generator_args)
        registry = SavonRegistry.new(wsdl, @generator_args)
        generator.add_exceptions(registry.soap_exceptions)
        generator.add_methods(registry.soap_methods)
        generator.add_namespaces(registry.soap_namespaces)
        generator.add_types(registry.soap_types)
        registry_file.write(generator.generate_code())
        registry_file.close
      end

    end
  end
end
