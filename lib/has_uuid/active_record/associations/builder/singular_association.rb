module HasUuid
  module ActiveRecord
    module Associations
      module Builder
        module SingularAssociation
          extend ActiveSupport::Concern
          included do
            def define_writers_with_uuid
              define_writers_without_uuid

              mixin.class_eval <<-CODE, __FILE__, __LINE__ + 1
                def #{name.to_s.singularize}_uuid=(uuids)
                  association(:#{name}).uuid_writer(uuids)
                end

                def #{name.to_s.singularize}_uuid
                  association(:#{name}).uuid_reader
                end
              CODE
            end

            alias_method_chain :define_writers, :uuid
          end
        end
      end
    end
  end
end
