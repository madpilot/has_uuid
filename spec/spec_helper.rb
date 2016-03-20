$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))

require 'rubygems'
require 'bundler'

begin
  Bundler.setup(:default, :development)
rescue Bundler::BundlerError => e
  $stderr.puts e.message
  $stderr.puts "Run `bundle install` to install missing gems"
  exit e.status_code
end

require 'thread'
require 'sqlite3'
require 'rails/all'
require 'database_cleaner'
require 'mocha/api'

require 'has_uuid'

class TestApp < Rails::Application
  config.root = File.dirname(__FILE__)
end

Rails.application = TestApp
HasUuid::Railtie.initializers.first.run(Rails.application)

ActiveRecord::Base.logger = Logger.new(File.dirname(__FILE__) + "/debug.log")
ActiveRecord::Migration.verbose = false
ActiveRecord::Base.configurations = YAML::load(File.read(File.dirname(__FILE__) + "/config/database.yml"))
ActiveRecord::Base.establish_connection(ENV["DB"] || "sqlite3")
DatabaseCleaner.strategy = :transaction

class SetupDatabase < ActiveRecord::Migration
  def up
    create_table :publishers do |t|
      t.string :name
      t.uuid :uuid
    end

    create_table :publishers_record_labels, :id => false do |t|
      t.integer :publisher_id
      t.uuid :publisher_uuid
      t.integer :record_label_id
      t.uuid :record_label_uuid
    end

    create_table :record_labels do |t|
      t.string :name
      t.uuid :uuid
    end

    create_table :albums do |t|
      t.uuid :uuid
      t.string :name
      t.integer :record_label_id
      t.uuid :record_label_uuid
      t.integer :artist_id
      t.uuid :artist_uuid
    end

    create_table :artists do |t|
      t.uuid :artist_identifier
      t.string :name
    end

    create_table :songs do |t|
      t.string :name
      t.integer :artist_id
    end
  end

  def down
    drop_table :publishers
    drop_table :publishers_record_labels
    drop_table :record_labels
    drop_table :albums
    drop_table :artists
    drop_table :songs
  end
end

class Publisher < ActiveRecord::Base
  has_uuid
  has_and_belongs_to_many :record_labels
end

class RecordLabel < ActiveRecord::Base
  has_uuid
  has_and_belongs_to_many :publishers
  has_many :artists, :through => :albums
  has_many :albums
end

class Album < ActiveRecord::Base
  has_uuid
  belongs_to :record_label
  belongs_to :artist
  has_many :songs
end

class Artist < ActiveRecord::Base
  has_uuid :primary_uuid => :artist_identifier
  has_many :record_companies, :through => :albums
end

class Song < ActiveRecord::Base
  belongs_to :album
end

RSpec.configure do |config|
  config.before(:suite) do
    ActiveRecord::Base.establish_connection({
      :adapter => 'sqlite3',
      :database => ':memory:',
      :verbosity => 'quiet'
    })
    Arel::Table.engine = Arel::Sql::Engine.new(ActiveRecord::Base)
    SetupDatabase.migrate(:up)

    DatabaseCleaner.strategy = :transaction
    DatabaseCleaner.clean_with(:truncation)
  end

  config.around(:each) do |example|
    DatabaseCleaner.cleaning do
      example.run
    end
  end
end
