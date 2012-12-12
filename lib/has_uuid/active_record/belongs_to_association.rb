module HasUuid
  module ActiveRecord
    module BelongsToAssociation
      extend ActiveSupport::Concern

      included do
        def replace_keys_with_uuid(record)
          if record.class.respond_to?(:has_uuid?) && record.class.has_uuid?
            if foreign_uuid_present?
              if record
                owner[reflection.foreign_uuid] = record[reflection.association_uuid_key(record.class)]
              else
                owner[reflections.foreign_uuid] = nil
              end
            end
          end
          replace_keys_without_uuid(record)
        end
        alias_method_chain :replace_keys, :uuid
      end

      def foreign_uuid_present?
        owner.class.columns.map(&:name).include?(reflection.foreign_uuid.to_s)
      end
    end
  end
end
