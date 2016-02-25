source "http://rubygems.org"

gem "uuidtools"
gem "activeuuid"

group :development do
  gem "simplecov", :require => false
  gem "jeweler"
  gem "bundler"
  gem "rdoc", "~> 3.4"
  gem "guard"
  gem "guard-test"
  gem "rb-fsevent"
end

group :test do
  gem "database_cleaner"
  gem "shoulda"
  gem "sqlite3"

  if ENV["RAILS_VERSION"]
    gem "rails", "~> #{ENV["RAILS_VERSION"]}"
  else
    gem "rails", "~> 3.2.13"
  end
  gem "mocha"
  gem "rake"
end
