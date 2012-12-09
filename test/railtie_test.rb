require 'helper'

class RailtieTest < Test::Unit::TestCase
  context 'Railtie' do
    setup do
      setup_database
      setup_fixtures
    end

    should 'not enable has_uuid if has_uuid is not called' do
      assert_equal false, Song.respond_to?(:has_uuid_options) 
    end

    should 'enable has_uuid if has_uuid is called' do
      assert_equal true, Artist.respond_to?(:has_uuid_options)
    end

    context 'migrations' do
      should 'set the sql_type to binary(16)' do
        uuid = RecordLabel.columns.dup.delete_if { |c| c.name != 'uuid' }.first
        assert_equal 'binary(16)', uuid.sql_type
      end
    end
  end
end
