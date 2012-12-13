require 'helper'

class TestHasUuid < Test::Unit::TestCase
  context 'has_uuid' do
    should 'add the has_uuid class method' do
      assert_equal true, RecordLabel.respond_to?(:has_uuid)
    end

    should 'default primary_uuid to uuid' do
      assert_equal :uuid, RecordLabel.primary_uuid
    end

    should 'take primary_uuid as option' do
      assert_equal :artist_identifier, Artist.primary_uuid
    end

    should 'alias uuid to the primary_uuid value if primary_uuid is not :uuid' do
      artist = Artist.create(:name => 'MxPx', :artist_identifier => UUIDTools::UUID.random_create)
      assert_equal artist.artist_identifier, artist.uuid
      new_uuid = UUIDTools::UUID.random_create
      artist.uuid = new_uuid
      assert_equal new_uuid, artist.uuid
    end
  end

  context 'check_uuid' do
    should 'return false if this is a new object and another object has the same uuid' do
      artist_1 = Artist.create(:name => 'NOFX', :artist_identifier => UUIDTools::UUID.random_create)
      artist_2 = Artist.new(:name => 'The Descendents', :uuid => artist_1.uuid)
      assert_equal false, HasUuid.check_uuid(artist_2)
    end

    should 'return false if this is an existing object, and another object has the same uuid' do
      artist_1 = Artist.create(:name => 'Pennywise', :artist_identifier => UUIDTools::UUID.random_create)
      artist_2 = Artist.create(:name => 'Bad Religion', :artist_identifier => UUIDTools::UUID.random_create)
      artist_2.uuid = artist_1.uuid
      assert_equal false, HasUuid.check_uuid(artist_2)
    end

    should 'return true if the object is a new object and has a unique uuid' do
      artist_1 = Artist.new(:name => 'Millencolin', :artist_identifier => UUIDTools::UUID.random_create)
      assert_equal true, HasUuid.check_uuid(artist_1)
    end

    should 'return true if the object is existing and has a unique uuid' do
      artist_1 = Artist.create(:name => 'Lagwagon', :artist_identifier => UUIDTools::UUID.random_create)
      assert_equal true, HasUuid.check_uuid(artist_1)
    end
  end

  context 'generate_uuids_if_needed' do
    should 'set a uuid if the uuid is empty' do
      label = RecordLabel.new(:name => '13th Floor Records')
      assert_nil label.uuid
      label.save!
      assert_not_nil label.uuid
    end

    should 'not set a uuid if uuid is not empty' do
      uuid = UUIDTools::UUID.random_create
      label = RecordLabel.create!(:name => 'Adeline Records', :uuid => uuid)
      assert_equal uuid, label.uuid
    end

    should 'accept a string uuid on creation' do
      uuid = UUIDTools::UUID.random_create
      label = RecordLabel.create!(:name => 'Agit-Prop Records', :uuid => uuid.to_s)
      label.reload
      assert_equal uuid, label.uuid
    end

    should 'find a unique id if there is a clash' do
      uuid_1 = UUIDTools::UUID.random_create
      uuid_2 = UUIDTools::UUID.random_create
      assert_not_equal uuid_1, uuid_2

      UUIDTools::UUID.stubs(:random_create).returns(uuid_1).then.returns(uuid_1).then.returns(uuid_2)
      RecordLabel.create!(:name => 'A-F Records') 
     
      label = RecordLabel.new(:name => 'Alternative Tentacles')
      assert_nil label.uuid
      label.save!
      assert_not_equal uuid_1, label.uuid
      assert_equal uuid_2, label.uuid
    end
  end
end
