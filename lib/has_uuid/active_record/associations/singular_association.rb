module HasUuid
  module ActiveRecord
    module Associations
      module SingularAssociation
        extend ActiveSupport::Concern
        included do
          def uuid_writer(uuid)
            replace(klass.find(uuid)) unless uuid.nil? || uuid.to_s.empty?
            replace(nil) if uuid.nil? || uuid.to_s.empty?
          end

          def uuid_reader(force_reload = false)
            id = self.owner.send(reflection.foreign_key)
            if id
              klass.find(id).uuid
            else
              nil
            end
          end
        end
      end
    end
  end
end
