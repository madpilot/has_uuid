module HasUuid
  class Railtie < Rails::Railtie
    initializer 'has_uuid' do |app|
      ActiveSupport.on_load :active_record do
        ::ActiveRecord::ConnectionAdapters::Table.send :include, HasUuid::ActiveRecord::ConnectionAdapters::Migration if defined? ::ActiveRecord::ConnectionAdapters::Table
        ::ActiveRecord::ConnectionAdapters::TableDefinition.send :include, HasUuid::ActiveRecord::ConnectionAdapters::Migration if defined? ::ActiveRecord::ConnectionAdapters::TableDefinition
        
        ::ActiveRecord::ConnectionAdapters::Column.send :include, HasUuid::ActiveRecord::ConnectionAdapters::Column
        ::ActiveRecord::ConnectionAdapters::Quoting.send :include, HasUuid::ActiveRecord::ConnectionAdapters::Quoting
        
        ::ActiveRecord::Relation.send :include, HasUuid::ActiveRecord::FinderMethods
        ::ActiveRecord::Reflection::AssociationReflection.send :include, HasUuid::ActiveRecord::AssociationReflection
        ::ActiveRecord::Associations::BelongsToAssociation.send :include, HasUuid::ActiveRecord::BelongsToAssociation
        ::ActiveRecord::Base.send :include, HasUuid
      end
    end
  end
end
