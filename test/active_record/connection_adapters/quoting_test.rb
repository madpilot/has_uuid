require 'helper'

class QuotingTest < Test::Unit::TestCase
  context 'Quoting' do
    setup do
      setup_database
      setup_fixtures
    end

    context 'quote_with_uuid' do
      should 'patch quote' do
        assert_equal true, ActiveRecord::Base::connection.respond_to?(:quote_with_uuid)
      end

      should 'quote the uuid as a binary' do
        uuid = UUIDTools::UUID.random_create
        column = RecordLabel.columns.dup.delete_if { |c| c.name != 'uuid' }.first
        assert_equal "'#{uuid.raw}'", ActiveRecord::Base::connection.quote(uuid, column) 
      end

      should 'quote a string uuid as a binary' do
        uuid = UUIDTools::UUID.random_create
        column = RecordLabel.columns.dup.delete_if { |c| c.name != 'uuid' }.first
        assert_equal "'#{uuid.raw}'", ActiveRecord::Base::connection.quote(uuid.to_s, column) 
      end
    end

    context 'type_cast_with_uuid' do
      should 'patch type_cast' do
        assert_equal true, ActiveRecord::Base::connection.respond_to?(:type_cast_with_uuid)
      end

      should 'convert the uuid to raw' do
        uuid = UUIDTools::UUID.random_create
        column = RecordLabel.columns.dup.delete_if { |c| c.name != 'uuid' }.first
        assert_equal uuid.raw, ActiveRecord::Base::connection.type_cast(uuid, column) 
      end

      should 'convert a uuid that is a string to raw' do
        uuid = UUIDTools::UUID.random_create
        column = RecordLabel.columns.dup.delete_if { |c| c.name != 'uuid' }.first
        assert_equal uuid.raw, ActiveRecord::Base::connection.type_cast(uuid.to_s, column) 
      end
    end
  end
end
