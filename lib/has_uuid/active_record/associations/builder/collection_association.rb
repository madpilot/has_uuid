module HasUuid
  module ActiveRecord
    module Associations
      module Builder
        module CollectionAssociation
          extend ActiveSupport::Concern
          def self.included(base)
            if ::ActiveRecord::VERSION::STRING >= "4.1"
              base.extend RedefinedReader
              base.extend RedefinedWriter

              base.class_eval do
                class << self
                  alias_method_chain :define_readers, :uuid_args
                  alias_method_chain :define_writers, :uuid_args
                end
              end

            else
              base.include RedefinedReader
              base.include RedefinedWriter

              base.class_eval do
                alias_method_chain :define_readers, :uuid_no_args
                alias_method_chain :define_writers, :uuid_no_args
              end
            end
          end

          module RedefinedReader
            def define_readers_with_uuid(mixin, name)
              mixin.class_eval <<-CODE, __FILE__, __LINE__ + 1
                def #{name.to_s.singularize}_uuids
                  association(:#{name}).uuids_reader
                end
              CODE
            end

            def define_readers_with_uuid_args(mixin, name)
              define_readers_without_uuid_args(mixin, name)
              define_readers_with_uuid(mixin, name)
            end

            def define_readers_with_uuid_no_args
              define_readers_without_uuid_no_args
              define_readers_with_uuid(mixin, name)
            end
          end

          module RedefinedWriter
            def define_writers_with_uuid(mixin, name)
              mixin.class_eval <<-CODE, __FILE__, __LINE__ + 1
                def #{name.to_s.singularize}_uuids=(uuids)
                  association(:#{name}).uuids_writer(uuids)
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
