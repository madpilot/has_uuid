require "spec_helper"

context "railtie" do
  it "should not enable has_uuid if has_uuid is not called" do
    expect(Song.respond_to?(:has_uuid_options)).to eq(false)
  end

  it "should enable has_uuid if has_uuid is called" do
    expect(Artist.respond_to?(:has_uuid_options)).to eq(true)
  end

  context "migrations" do
    it "should set the sql_type to binary(16)" do
      uuid = RecordLabel.columns.dup.delete_if { |c| c.name != "uuid" }.first
      expect(uuid.sql_type).to eq("binary(16)")
    end
  end
end
