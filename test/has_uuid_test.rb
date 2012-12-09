require 'helper'

class TestHasUuid < Test::Unit::TestCase
  context 'has_uuid' do
    should 'add the has_uuid class method' do
      assert_equal true, RecordLabel.respond_to?(:has_uuid)
    end
  end

  context 'check_uuid' do
    should 'add the check_uuid instance method' do
      artist = RecordLabel.new
      assert_equal true, artist.respond_to?(:check_uuid)
    end
  end

  context 'validate_uuid' do
    should 'add the check_uuid instance method' do
      artist = RecordLabel.new
      assert_equal true, artist.respond_to?(:validate_uuid)
    end
  end
  
  context 'create_uuid' do
    should 'add the create_uuid instance method' do
      artist = RecordLabel.new
      assert_equal true, artist.respond_to?(:create_uuid)
    end

    should 'call create_uuid on create' do
      RecordLabel.any_instance.expects(:create_uuid)
      RecordLabel.create!(:name => 'Fat Wreck Chords')
    end
  end
end
