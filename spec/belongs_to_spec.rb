require "spec_helper"

context "belongs_to" do
   it "should assign uuids when set" do
    record_label = RecordLabel.create(name: "Fat Wreck Chords", uuid: UUIDTools::UUID.random_create)
    album = Album.create(name: "Wolf in Wolves Clothing", :record_label => record_label)
    album.reload
    expect(album.record_label_uuid).to eq(record_label.uuid)
  end

  it "should assign ids when set" do
    record_label = RecordLabel.create(name: "Epitaph Records", uuid: UUIDTools::UUID.random_create)
    album = Album.create(name: "No Control", :record_label_id => record_label.id)
    album.reload
    expect(album.record_label_uuid).to eq(record_label.uuid)
  end

  it "should replace the objects when uuid_ids is set" do
    record_label = RecordLabel.create(name: "Misfits Records", uuid: UUIDTools::UUID.random_create)
    album = Album.create(name: "Project 1950", :record_label_uuid => record_label.uuid)
    album.reload
    expect(album.record_label).to eq(record_label)
  end
end
