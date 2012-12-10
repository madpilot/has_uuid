module HasUuid
  class Railtie < Rails::Railtie
    initializer 'has_uuid' do |app|
      ActiveSupport.on_load :active_record do
        ::ActiveRecord::Relation.send :include, HasUuid::ActiveRecord::FinderMethods
        ::ActiveRecord::Reflection::AssociationReflection.send :include, HasUuid::ActiveRecord::AssociationReflection
        ::ActiveRecord::Associations::BelongsToAssociation.send :include, HasUuid::ActiveRecord::BelongsToAssociation
        ::ActiveRecord::Base.send :include, HasUuid
      end
      
      ActiveSupport.on_load :activeuuid do
        # We don't want our ids to be UUIDs so override activeuuid's implementation
        ::ActiveRecord::ConnectionAdapters::Table.send :include, HasUuid::ActiveRecord::ConnectionAdapters::Migrations if defined? ActiveRecord::ConnectionAdapters::Table
        ::ActiveRecord::ConnectionAdapters::TableDefinition.send :include, HasUuid::ActiveRecord::ConnectionAdapters::Migrations if defined? ActiveRecord::ConnectionAdapters::TableDefinition
      end
    end
  end
end
