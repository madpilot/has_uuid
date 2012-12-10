require 'helper'

class TestHasUuid < Test::Unit::TestCase
  context 'has_uuid' do
    should 'add the has_uuid class method' do
      assert_equal true, RecordLabel.respond_to?(:has_uuid)
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
  end

  context 'finder' do
    should 'allow you to search via uuid as an id' do
      uuid = UUIDTools::UUID.random_create
      label = RecordLabel.create!(:name => 'Agit-Prop Records', :uuid => uuid.to_s)
      assert_equal label, RecordLabel.find(uuid)
    end

    should 'allow you to search multiple uuids as an array of uuids' do
      label1 = RecordLabel.create!(:name => 'Agit-Prop Records')
      label2 = RecordLabel.create!(:name => 'Agit-Prop Records')
      label3 = RecordLabel.create!(:name => 'Agit-Prop Records')
      label4 = RecordLabel.create!(:name => 'Agit-Prop Records')

      arr = [label1, label2, label3, label4]

      labels = RecordLabel.find(arr.map(&:uuid))
      assert_same_elements arr, labels
    end

    should 'allow you to search multiple uuids as an array of strings' do
      label1 = RecordLabel.create!(:name => 'Agit-Prop Records')
      label2 = RecordLabel.create!(:name => 'Agit-Prop Records')
      label3 = RecordLabel.create!(:name => 'Agit-Prop Records')
      label4 = RecordLabel.create!(:name => 'Agit-Prop Records')

      arr = [label1, label2, label3, label4]

      labels = RecordLabel.find(arr.map(&:uuid).map(&:to_s))
      assert_same_elements arr, labels
    end



    should 'allow you to search via uuid string as an id' do
      uuid = UUIDTools::UUID.random_create
      label = RecordLabel.create!(:name => 'Agit-Prop Records', :uuid => uuid.to_s)
      assert_equal label, RecordLabel.find(uuid.to_s)
    end

    should 'allow you to search via arel' do
      uuid = UUIDTools::UUID.random_create
      label = RecordLabel.create!(:name => 'All About Records', :uuid => uuid)
      assert_equal label, RecordLabel.where('uuid = ?', uuid).first
    end

    should 'allow you to search via arel where uuid query is a string' do
      uuid = UUIDTools::UUID.random_create
      label = RecordLabel.create!(:name => 'All the Madmen', :uuid => uuid)
      assert_equal label, RecordLabel.where('uuid = ?', uuid.to_s).first
    end

    should 'ensure uuid is unique' do
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
