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

    should 'find associated has_and_belongs_to objects' do
      label1 = RecordLabel.create!(:name => 'Agit-Prop Records')
      label2 = RecordLabel.create!(:name => 'All the Madmen')
      label3 = RecordLabel.create!(:name => 'Alternative Tentacles')
      label4 = RecordLabel.create!(:name => 'Amphetamine Reptile Records')
    
      publisher1 = Publisher.create!(:name => 'Sony')
      publisher2 = Publisher.create!(:name => 'Polygram')

      label1.publishers = [ publisher1, publisher2 ]
      label2.publishers = [ publisher1 ]
      
      label1.save!
      label2.save!

      label1 = RecordLabel.find(label1.id)
      label2 = RecordLabel.find(label2.id)

      assert_same_elements [ publisher1.uuid, publisher2.uuid ], label1.publisher_uuids
      assert_same_elements [ label1.uuid, label2.uuid ], publisher1.record_label_uuids
      
      assert_same_elements [ publisher1, publisher2 ], label1.publishers
      assert_same_elements [ label1, label2 ], publisher1.record_labels
    end
  end
end
