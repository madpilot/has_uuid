module HasUuid
  module ActiveRecord
    module Associations
      module Builder
        module SingularAssociation
          extend ActiveSupport::Concern

          def self.included(base)
            if ::ActiveRecord::VERSION::STRING >= "4.1"
              base.extend RedefinedWriter
              base.class_eval do
                class << self
                  alias_method_chain :define_writers, :uuid_args
                end
              end
            else
              base.class_eval do
                include RedefinedWriter
                alias_method_chain :define_writers, :uuid_no_args
              end
            end
          end

          module RedefinedWriter
            def define_writers_with_uuid(mixin, name)
              mixin.class_eval <<-CODE, __FILE__, __LINE__ + 1
                def #{name.to_s.singularize}_uuid=(uuids)
                  association(:#{name}).uuid_writer(uuids)
                end

                def #{name.to_s.singularize}_uuid
                  association(:#{name}).uuid_reader
                end
              CODE
            end

            def define_writers_with_uuid_args(mixin, name)
              define_writers_without_uuid_args(mixin, name)
              define_writers_with_uuid(mixin, name)
            end

            def define_writers_with_uuid_no_args
              define_writers_without_uuid_no_args
              define_writers_with_uuid(mixin, name)
            end
          end
        end
      end
    end
  end
end
