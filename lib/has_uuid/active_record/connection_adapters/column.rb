module HasUuid
  module ActiveRecord
    module ConnectionAdapters
      module Column
        extend ActiveSupport::Concern

        included do
          def type_cast_with_uuid(value)
            klass = self.class
            return klass.binary_to_uuid(value) if type == :uuid
            type_cast_without_uuid(value)
          end

          def type_cast_code_with_uuid(var_name)
            klass = self.class
            return "#{klass}.binary_to_uuid(#{var_name})" if type == :uuid
            type_cast_code_without_uuid(var_name)
          end

          def simplified_type_with_uuid(field_type)
            return :uuid if field_type == 'binary(16)'
            simplified_type_without_uuid(field_type)
          end

          alias_method_chain :type_cast, :uuid
          alias_method_chain :type_cast_code, :uuid
          alias_method_chain :simplified_type, :uuid

          class << self
            def binary_to_uuid(value)
              UUIDTools::UUID.parse_raw(value) unless value.nil?
            end
          end
        end
      end
    end
  end
end
