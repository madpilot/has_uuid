require 'helper'

class ColumnTest < Test::Unit::TestCase
  context 'column' do
    setup do
      setup_database
      setup_fixtures
    end

    should 'add the uuid database column type' do
      uuid = RecordLabel.columns.dup.delete_if { |c| c.name != 'uuid' }.first
      assert_equal :uuid, uuid.type
    end
   
    should 'return a UUID when type_cast' do
      data = UUIDTools::UUID.random_create
      uuid = RecordLabel.columns.dup.delete_if { |c| c.name != 'uuid' }.first
      cast = uuid.type_cast(data.raw)
      assert_equal true, cast.is_a?(UUIDTools::UUID)
      assert_equal data, cast
    end
    
    should 'return nil when type_cast value is nil' do
      uuid = RecordLabel.columns.dup.delete_if { |c| c.name != 'uuid' }.first
      cast = uuid.type_cast(nil)
      assert_equal true, cast.nil?
    end

    should 'return string version of type_cast_code' do
      uuid = RecordLabel.columns.dup.delete_if { |c| c.name != 'uuid' }.first
      assert_equal "ActiveRecord::ConnectionAdapters::SQLiteColumn.binary_to_uuid(uuid)", uuid.type_cast_code(:uuid)
    end

    should 'return binary(16) for simplified_type_with_uuid' do
      uuid = RecordLabel.columns.dup.delete_if { |c| c.name != 'uuid' }.first
      assert_equal :uuid, uuid.send(:simplified_type, 'binary(16)')
    end
  end
end
