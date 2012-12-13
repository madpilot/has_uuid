module HasUuid
  module ActiveRecord
    module Associations
      module Builder
        module CollectionAssociation
          extend ActiveSupport::Concern
          included do
            def define_readers_with_uuid
              define_readers_without_uuid
            
              mixin.class_eval <<-CODE, __FILE__, __LINE__ + 1
                def #{name.to_s.singularize}_uuids
                  association(:#{name}).uuids_reader
                end
              CODE
            end

            def define_writers_with_uuid
              define_writers_without_uuid

              mixin.class_eval <<-CODE, __FILE__, __LINE__ + 1
                def #{name.to_s.singularize}_uuids=(uuids)
                  association(:#{name}).uuids_writer(uuids)
                end
              CODE
            end

            alias_method_chain :define_readers, :uuid
            alias_method_chain :define_writers, :uuid
          end
        end
      end
    end
  end
end 
