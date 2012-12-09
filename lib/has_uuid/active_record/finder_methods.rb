module HasUuid
  VALID_FORMAT = /^([0-9a-f]{8})-([0-9a-f]{4})-([0-9a-f]{4})-([0-9a-f]{2})([0-9a-f]{2})-([0-9a-f]{12})$/
  
  module ActiveRecord
    module FinderMethods
      def find_one(id)
        return self.find_by_uuid(id) if id.is_a?(::UUIDTools::UUID) || id.to_s =~ VALID_FORMAT
        super
      end

      # :nocov:
      def find_some(ids)
        if ids.length > 0 && ids.inject(true) { |r, id| r && (id.is_a?(::UUIDTools::UUID) || id.to_s =~ VALID_FORMAT) }
          uuids = ids.map do |id|
            id = ::UUIDTools::UUID.parse(id) if id.is_a?(String)
            id.raw
          end
          result = where(table[:uuid].in(uuids)).all
        
          expected_size =
            if @limit_value && ids.size > @limit_value
              @limit_value
            else
              ids.size
            end

            if @offset_value && (ids.size - @offset_value < expected_size)
              expected_size = ids.size - @offset_value
            end

            if result.size == expected_size
              result
            else
              conditions = arel.where_sql
              conditions = " [#{conditions}]" if conditions
              error = "Couldn't find all #{@klass.name.pluralize} with UUIDs "
              error << "(#{ids.join(", ")})#{conditions} (found #{result.size} results, but was looking for #{expected_size})"
              raise ::ActiveRecord::RecordNotFound, error
            end
        else
          super
        end
      end
    end
  end
end
