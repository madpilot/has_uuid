require 'helper'

class TestBelongsTo < Test::Unit::TestCase
  context 'finder' do
    should 'allow you to search via uuid as an id' do
      uuid = UUIDTools::UUID.random_create
      label = RecordLabel.create!(:name => 'Agit-Prop Records', :uuid => uuid)
      assert_equal label, RecordLabel.find(uuid)
    end

    should 'allow you to search multiple uuids as an array of uuids' do
      label1 = RecordLabel.create!(:name => 'Agit-Prop Records')
      label2 = RecordLabel.create!(:name => 'All the Madmen')
      label3 = RecordLabel.create!(:name => 'Alternative Tentacles')
      label4 = RecordLabel.create!(:name => 'Amphetamine Reptile Records')

      arr = [label1, label2, label3, label4]

      labels = RecordLabel.find(arr.map(&:uuid))
      assert_same_elements arr, labels
    end

    should 'allow you to search multiple uuids as an array of strings' do
      label1 = RecordLabel.create!(:name => 'Anti-Creative Records')
      label2 = RecordLabel.create!(:name => 'Asian Man Records')
      label3 = RecordLabel.create!(:name => 'Autumn + Colour Records')
      label4 = RecordLabel.create!(:name => 'Bad Taste Records')

      arr = [label1, label2, label3, label4]

      labels = RecordLabel.find(arr.map(&:uuid).map(&:to_s))
      assert_same_elements arr, labels
    end

    should 'allow you to search via uuid string as an id' do
      uuid = UUIDTools::UUID.random_create
      label = RecordLabel.create!(:name => 'Beat Butchers', :uuid => uuid)
      assert_equal label, RecordLabel.find(uuid.to_s)
    end

    should 'allow you to search via arel' do
      uuid = UUIDTools::UUID.random_create
      label = RecordLabel.create!(:name => 'Big Rig Records', :uuid => uuid)
      assert_equal label, RecordLabel.where('uuid = ?', uuid).first
    end
  end
end
