module HasUuid
  module ActiveRecord
    module ConnectionAdapters
      module Quoting
        extend ActiveSupport::Concern
        
        included do
          def quote_with_uuid(value, column = nil)
            value = uuid_to_raw(value) if column && column.type.to_sym == :uuid
            quote_without_uuid(value, column)
          end

          def type_cast_with_uuid(value, column = nil)
            value = uuid_to_raw(value) if column && column.type.to_sym == :uuid
            type_cast_without_uuid(value, column)
          end

        private
          def uuid_to_raw(value)
            return nil if value.nil?
            value = UUIDTools::UUID.parse(value) if value.is_a?(String)
            value.raw
          end
          
          alias_method_chain :quote, :uuid
          alias_method_chain :type_cast, :uuid
        end
      end
    end
  end
end
