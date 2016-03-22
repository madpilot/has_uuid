module HasUuid
  class Railtie < Rails::Railtie
    initializer 'has_uuid' do |app|
      ActiveSupport.on_load :active_record do
        ::ActiveRecord::Relation.send :include, HasUuid::ActiveRecord::FinderMethods
        ::ActiveRecord::Reflection::AssociationReflection.send :include, HasUuid::ActiveRecord::Reflection::AssociationReflection
        ::ActiveRecord::Associations::BelongsToAssociation.send :include, HasUuid::ActiveRecord::BelongsToAssociation
        ::ActiveRecord::Associations::SingularAssociation.send :include, HasUuid::ActiveRecord::Associations::SingularAssociation
        ::ActiveRecord::Associations::CollectionAssociation.send :include, HasUuid::ActiveRecord::Associations::CollectionAssociation
        ::ActiveRecord::Associations::Builder::SingularAssociation.send :include, HasUuid::ActiveRecord::Associations::Builder::SingularAssociation
        ::ActiveRecord::Associations::Builder::CollectionAssociation.send :include, HasUuid::ActiveRecord::Associations::Builder::CollectionAssociation
        ::ActiveRecord::Base.send :include, HasUuid::Mixin
      end

      ActiveSupport.on_load :activeuuid do
        # We don't want our ids to be UUIDs so override activeuuid's implementation
        ::ActiveRecord::ConnectionAdapters::Table.send :include, HasUuid::ActiveRecord::ConnectionAdapters::Migrations if defined? ActiveRecord::ConnectionAdapters::Table
        ::ActiveRecord::ConnectionAdapters::TableDefinition.send :include, HasUuid::ActiveRecord::ConnectionAdapters::Migrations if defined? ActiveRecord::ConnectionAdapters::TableDefinition
      end
    end
  end
end
