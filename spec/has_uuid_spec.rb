require "spec_helper"

describe HasUuid do
  it "has a version number" do
    expect(HasUuid::VERSION).not_to be nil
  end

  context "has_uuid" do
    it "should add the has_uuid class method" do
      expect(RecordLabel).respond_to?(:has_uuid)
    end

    it "should default primary_uuid to uuid" do
      expect(RecordLabel.primary_uuid).to eq(:uuid)
    end

    it "should take primary_uuid as option" do
      expect(Artist.primary_uuid).to eq(:artist_identifier)
    end

    it "should alias uuid to the primary_uuid value if primary_uuid is not :uuid" do
      artist = Artist.create(name: "MxPx", artist_identifier: UUIDTools::UUID.random_create)
      expect(artist.artist_identifier).to eq(artist.uuid)
      new_uuid = UUIDTools::UUID.random_create
      artist.uuid = new_uuid
      expect(artist.uuid).to eq(new_uuid)
    end
  end

  context "check_uuid" do
    it "should return false if this is a new object and another object has the same uuid" do
      artist_1 = Artist.create(name: "NOFX", artist_identifier: UUIDTools::UUID.random_create)
      artist_2 = Artist.new(name: "The Descendents", uuid: artist_1.uuid)
      expect(HasUuid.check_uuid(artist_2)).to eq(false)
    end

    it "should return false if this is an existing object, and another object has the same uuid" do
      artist_1 = Artist.create(name: "Pennywise", artist_identifier: UUIDTools::UUID.random_create)
      artist_2 = Artist.create(name: "Bad Religion", artist_identifier: UUIDTools::UUID.random_create)
      artist_2.uuid = artist_1.uuid
      expect(HasUuid.check_uuid(artist_2)).to eq(false)
    end

    it "should return true if the object is a new object and has a unique uuid" do
      artist_1 = Artist.new(name: "Millencolin", artist_identifier: UUIDTools::UUID.random_create)
      expect(HasUuid.check_uuid(artist_1)).to eq(true)
    end

    it "should return true if the object is existing and has a unique uuid" do
      artist_1 = Artist.create(name: "Lagwagon", artist_identifier: UUIDTools::UUID.random_create)
      expect(HasUuid.check_uuid(artist_1)).to eq(true)
    end
  end

  context "generate_uuids_if_needed" do
    it "should set a uuid if the uuid is empty" do
      label = RecordLabel.new(name: "13th Floor Records")
      expect(label.uuid).to be_nil
      label.save!
      expect(label.uuid).to_not be_nil
    end

    it "should not set a uuid if uuid is not empty" do
      uuid = UUIDTools::UUID.random_create
      label = RecordLabel.create!(name: "Adeline Records", uuid: uuid)
      expect(label.uuid).to eq(uuid)
    end

    it "should accept a string uuid on creation" do
      uuid = UUIDTools::UUID.random_create
      label = RecordLabel.create!(name: "Agit-Prop Records", uuid: uuid.to_s)
      label.reload
      expect(label.uuid).to eq(uuid)
    end

    it "should find a unique id if there is a clash" do
      uuid_1 = UUIDTools::UUID.random_create
      uuid_2 = UUIDTools::UUID.random_create
      expect(uuid_1).to_not eq(uuid_2)

      UUIDTools::UUID.stubs(:random_create).returns(uuid_1).then.returns(uuid_1).then.returns(uuid_2)
      RecordLabel.create!(name: "A-F Records")

      label = RecordLabel.new(name: "Alternative Tentacles")
      expect(label.uuid).to be_nil
      label.save!
      expect(label.uuid).to_not eq(uuid_1)
      expect(label.uuid).to eq(uuid_2)
    end
  end
end
