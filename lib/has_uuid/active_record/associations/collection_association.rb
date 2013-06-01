module HasUuid
  module ActiveRecord
    module Associations
      module CollectionAssociation
        extend ActiveSupport::Concern
        included do
          def uuids_reader
            if loaded? || options[:finder_sql]
              load_target.map do |record|
                record.send(reflection.association_primary_uuid)
              end
            else
              column  = "#{reflection.quoted_table_name}.#{reflection.association_primary_uuid}"
              association_scope.pluck(column)
            end
          end

          def uuids_writer(uuids)
            uuid_column = reflection.primary_uuid_column
            uuids = Array(uuids).reject { |uuid| uuid.blank? }
            uuids.map! { |u| uuid_column.type_cast(u) }
            replace(klass.find(uuids).index_by { |r| r.uuid }.values_at(*uuids))
          end
        end
      end
    end
  end
end
