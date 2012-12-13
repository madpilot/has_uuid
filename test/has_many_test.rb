require 'helper'

class TestHasMany < Test::Unit::TestCase
  context 'has_many' do
    should 'assign uuids when set' do
      record_label_1 = RecordLabel.create(:name => 'Fat Wreck Chords')
      album_1 = Album.create(:name => 'Wolf in Wolves Clothing', :uuid => UUIDTools::UUID.random_create)
      album_2 = Album.create(:name => 'Punk in Drublic', :uuid => UUIDTools::UUID.random_create)
      album_3 = Album.create(:name => 'Coaster', :uuid => UUIDTools::UUID.random_create)
      record_label_1.albums = [ album_1, album_2, album_3 ]
      assert_same_elements [ album_1.uuid, album_2.uuid, album_3.uuid ], record_label_1.album_uuids
    end

    should 'assign ids when set' do
      record_label_1 = RecordLabel.create(:name => 'Fat Wreck Chords')
      album_1 = Album.create(:name => 'Wolf in Wolves Clothing', :uuid => UUIDTools::UUID.random_create)
      album_2 = Album.create(:name => 'Punk in Drublic', :uuid => UUIDTools::UUID.random_create)
      album_3 = Album.create(:name => 'Coaster', :uuid => UUIDTools::UUID.random_create)
      record_label_1.album_ids = [ album_1.id, album_2.id, album_3.id ]
      assert_same_elements [ album_1.uuid, album_2.uuid, album_3.uuid ], record_label_1.album_uuids
    end

    should 'replace the objects when uuid_ids is set' do
      record_label_1 = RecordLabel.create(:name => 'Fat Wreck Chords')
      album_1 = Album.create(:name => 'Wolf in Wolves Clothing', :uuid => UUIDTools::UUID.random_create)
      album_2 = Album.create(:name => 'Punk in Drublic', :uuid => UUIDTools::UUID.random_create)
      album_3 = Album.create(:name => 'Coaster', :uuid => UUIDTools::UUID.random_create)
      record_label_1.album_uuids = [ album_1.uuid, album_2.uuid, album_3.uuid ]
      assert_same_elements [ album_1, album_2, album_3 ], record_label_1.albums
    end
  end
end
