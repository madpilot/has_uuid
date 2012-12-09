module HasUuid
  module ActiveRecord
    module AssociationReflection
      extend ActiveSupport::Concern
      
      included do
        def uuid_key_column
          @uuid_key_column ||= klass.columns.find { |c| c.name == klass.uuid_key }
        end


        def association_uuid_key(klass = nil)
          options[:uuid_key] || uuid_key(klass || self.klass)
        end
   
        def active_record_uuid_key
          @active_record_uuid_key ||= options[:uuid_key] || uuid_key(active_record)
        end

        def foreign_uuid
          @foreign_uuid ||= options[:foreign_uuid] || derive_foreign_uuid              
        end

      private
        def uuid_key(klass)
          klass.uuid_key || raise(UnknownPrimaryKey.new(klass))
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
