module HasUuid
  module ActiveRecord
    module Reflection
      module AssociationReflection
        extend ActiveSupport::Concern
        
        included do
          def primary_uuid_column
            @primary_uuid_column ||= klass.columns.find { |c| c.name.to_sym == klass.primary_uuid }
          end

          def association_primary_uuid(klass = nil)
            options[:primary_uuid] || primary_uuid(klass || self.klass)
          end
     
          def active_record_primary_uuid
            @active_record_primary_uuid ||= options[:primary_uuid] || primary_uuid(active_record)
          end

          def foreign_uuid
            @foreign_uuid ||= options[:foreign_uuid] || derive_foreign_uuid              
          end

        private
          def primary_uuid(klass)
            klass.primary_uuid || raise(UnknownPrimaryKey.new(klass))
          end

          def derive_foreign_uuid
            if belongs_to?
              "#{name}_uuid"
            elsif options[:as]
              "#{options[:as]}_uuid"
            else
              active_record.name.foreign_key
            end
          end
        end
      end
    end
  end
end
