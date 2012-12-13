require 'helper'

class TestBelongsTo < Test::Unit::TestCase
  context 'belongs_to' do
    should 'assign uuids when set' do
      record_label = RecordLabel.create(:name => 'Fat Wreck Chords', :uuid => UUIDTools::UUID.random_create)
      album = Album.create(:name => 'Wolf in Wolves Clothing', :uuid => UUIDTools::UUID.random_create, :record_label => record_label)
      album.reload
      assert_equal record_label.uuid, album.record_label_uuid
    end

    should 'assign ids when set' do
      record_label = RecordLabel.create(:name => 'Fat Wreck Chords', :uuid => UUIDTools::UUID.random_create)
      album = Album.create(:name => 'Wolf in Wolves Clothing', :uuid => UUIDTools::UUID.random_create, :record_label_id => record_label.id)
      album.reload
      assert_equal record_label.uuid, album.record_label_uuid
    end

    should 'replace the objects when uuid_ids is set' do
      record_label = RecordLabel.create(:name => 'Fat Wreck Chords', :uuid => UUIDTools::UUID.random_create)
      album = Album.create(:name => 'Wolf in Wolves Clothing', :uuid => UUIDTools::UUID.random_create, :record_label_uuid => record_label.uuid)
      album.reload
      assert_equal record_label, album.record_label
    end
  end
end
