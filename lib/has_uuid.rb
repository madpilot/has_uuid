require 'active_support'
require 'uuidtools'
require 'activeuuid'

module HasUuid
  def self.included(base)
    base.send :extend, ClassMethods
  end
  
  module ClassMethods
    def has_uuid(options = {})
      self.class_eval do
        cattr_accessor :has_uuid_options
        self.has_uuid_options = options
        options[:primary_uuid] ||= :uuid

        if options[:primary_uuid] != :uuid
          class_eval do
            include ActiveUUID::UUID

            def uuid
              self.send self.class.primary_uuid
            end

            def uuid=(uuid)
              self.send "#{self.class.primary_uuid}=".to_sym, uuid
            end
          end
        end

        class_eval do
          before_create :generate_uuids_if_needed
          
          def generate_uuids_if_needed
            unless self.uuid
              begin
                self.uuid = UUIDTools::UUID.random_create 
              end while !HasUuid.check_uuid(self)
            end
          end
        end
      end
    end

    def primary_uuid
      self.has_uuid_options[:primary_uuid]
    end
  end

  def self.check_uuid(klass)
    return false if klass.uuid && klass.id && klass.class.where("#{klass.class.primary_uuid} = ?", klass.uuid).where('id <> ?', klass.id).count > 0
    return false if klass.uuid && klass.new_record? && klass.class.where("#{klass.class.primary_uuid} = ?", klass.uuid).count > 0
    return true
  end
end

require File.join(File.dirname(__FILE__), 'has_uuid', 'active_record', 'connection_adapters', 'migration.rb')
require File.join(File.dirname(__FILE__), 'has_uuid', 'active_record', 'finder_methods.rb')
require File.join(File.dirname(__FILE__), 'has_uuid', 'active_record', 'reflection.rb')
require File.join(File.dirname(__FILE__), 'has_uuid', 'active_record', 'associations', 'singular_association.rb')
require File.join(File.dirname(__FILE__), 'has_uuid', 'active_record', 'associations', 'collection_association.rb')
require File.join(File.dirname(__FILE__), 'has_uuid', 'active_record', 'associations', 'builder', 'collection_association.rb')
require File.join(File.dirname(__FILE__), 'has_uuid', 'active_record', 'associations', 'builder', 'singular_association.rb')
require File.join(File.dirname(__FILE__), 'has_uuid', 'active_record', 'belongs_to_association.rb')
require File.join(File.dirname(__FILE__), 'has_uuid', 'railtie.rb')
