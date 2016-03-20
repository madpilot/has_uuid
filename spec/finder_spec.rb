require "spec_helper"

context "finder" do
  it "should allow you to search via uuid as an id" do
    uuid = UUIDTools::UUID.random_create
    label = RecordLabel.create!(name: "Agit-Prop Records", uuid: uuid)
    expect(RecordLabel.find(uuid)).to eq(label)
  end

  it "should allow you to search multiple uuids as an array of uuids" do
    label1 = RecordLabel.create!(name: "Agit-Prop Records")
    label2 = RecordLabel.create!(name: "All the Madmen")
    label3 = RecordLabel.create!(name: "Alternative Tentacles")
    label4 = RecordLabel.create!(name: "Amphetamine Reptile Records")

    arr = [label1, label2, label3, label4]

    labels = RecordLabel.find(arr.map(&:uuid))
    expect(labels).to eq(arr)
  end

  it "should allow you to search multiple uuids as an array of strings" do
    label1 = RecordLabel.create!(name: "Anti-Creative Records")
    label2 = RecordLabel.create!(name: "Asian Man Records")
    label3 = RecordLabel.create!(name: "Autumn + Colour Records")
    label4 = RecordLabel.create!(name: "Bad Taste Records")

    arr = [label1, label2, label3, label4]

    labels = RecordLabel.find(arr.map(&:uuid).map(&:to_s))
    expect(labels).to eq(arr)
  end

  it "should allow you to search via uuid string as an id" do
    uuid = UUIDTools::UUID.random_create
    label = RecordLabel.create!(name: "Beat Butchers", uuid: uuid)
    expect(RecordLabel.find(uuid.to_s)).to eq(label)
  end

  it "should allow you to search via arel" do
    uuid = UUIDTools::UUID.random_create
    label = RecordLabel.create!(name: "Big Rig Records", uuid: uuid)
    expect(RecordLabel.where("uuid = ?", uuid).first).to eq(label)
  end

  it "should find associated has_and_belongs_to objects" do
    label1 = RecordLabel.create!(name: "Agit-Prop Records")
    label2 = RecordLabel.create!(name: "All the Madmen")
    label3 = RecordLabel.create!(name: "Alternative Tentacles")
    label4 = RecordLabel.create!(name: "Amphetamine Reptile Records")

    publisher1 = Publisher.create!(name: "Sony")
    publisher2 = Publisher.create!(name: "Polygram")

    label1.publishers = [ publisher1, publisher2 ]
    label2.publishers = [ publisher1 ]

    label1.save!
    label2.save!

    label1 = RecordLabel.find(label1.id)
    label2 = RecordLabel.find(label2.id)

    expect(label1.publisher_uuids).to eq([ publisher1.uuid, publisher2.uuid ])
    expect(publisher1.record_label_uuids).to eq([ label1.uuid, label2.uuid ])

    expect(label1.publishers).to eq([ publisher1, publisher2 ])
    expect(publisher1.record_labels).to eq([ label1, label2 ])
  end
end
