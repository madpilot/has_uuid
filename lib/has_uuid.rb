require 'active_support'
require 'uuidtools'

module HasUuid
  def self.included(base)
    base.send :extend, ClassMethods
    base.class_eval do
      include InstanceMethods
    end
    base.send :validate, :validate_uuid
    base.send :before_create, :create_uuid
  end
  
  module ClassMethods
    def has_uuid(options = {})
      self.class_eval do
        cattr_accessor :has_uuid_options
        self.has_uuid_options = options
      end
    end
  end

  module InstanceMethods
    def check_uuid
      return false if self.uuid && self.id && self.class.where('uuid = ?', self.uuid.raw).where('id <> ?', self.id).count > 0
      return false if self.uuid && !self.id && self.class.where('uuid = ?', self.uuid.raw).count > 0
      return true
    end

    def validate_uuid
      if !check_uuid 
        self.errors.add(:uuid, "is already taken") 
        return false
      end
      return true
    end

    def create_uuid
      unless self.uuid
        begin
          self.uuid = UUIDTools::UUID.random_create 
        end while !check_uuid
      end
    end
  end
end

require File.join(File.dirname(__FILE__), 'has_uuid', 'active_record', 'connection_adapters', 'migration.rb')
require File.join(File.dirname(__FILE__), 'has_uuid', 'active_record', 'connection_adapters', 'column.rb')
require File.join(File.dirname(__FILE__), 'has_uuid', 'active_record', 'connection_adapters', 'quoting.rb')
require File.join(File.dirname(__FILE__), 'has_uuid', 'active_record', 'finder_methods.rb')
require File.join(File.dirname(__FILE__), 'has_uuid', 'active_record', 'association_reflection.rb')
require File.join(File.dirname(__FILE__), 'has_uuid', 'active_record', 'belongs_to_association.rb')
require File.join(File.dirname(__FILE__), 'has_uuid', 'railtie.rb')
