module HasUuid
  module ActiveRecord
    module ConnectionAdapters
      module Migration
        def uuid(*column_names)
          options = column_names.extract_options!
          column_names.each do |name|
            type = 'binary(16)'
            column(name, "#{type}", options)
          end
        end
      end
    end
  end
end
