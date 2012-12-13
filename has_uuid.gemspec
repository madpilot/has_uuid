# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "has_uuid"
  s.version = "0.0.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Myles Eftos"]
  s.date = "2012-12-12"
  s.description = "TODO: longer description of your gem"
  s.email = "myles@madpilot.com.au"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.md"
  ]
  s.files = [
    ".document",
    "Gemfile",
    "Gemfile.lock",
    "Guardfile",
    "LICENSE.txt",
    "README.md",
    "Rakefile",
    "VERSION",
    "lib/has_uuid.rb",
    "lib/has_uuid/active_record/association_reflection.rb",
    "lib/has_uuid/active_record/belongs_to_association.rb",
    "lib/has_uuid/active_record/connection_adapters/migration.rb",
    "lib/has_uuid/active_record/finder_methods.rb",
    "lib/has_uuid/railtie.rb",
    "test/config/database.yml",
    "test/has_uuid_test.rb",
    "test/helper.rb",
    "test/railtie_test.rb"
  ]
  s.homepage = "http://github.com/madpilot/has_uuid"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "TODO: one-line summary of your gem"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<uuidtools>, [">= 0"])
      s.add_runtime_dependency(%q<activeuuid>, [">= 0"])
      s.add_development_dependency(%q<simplecov>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, [">= 0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<rdoc>, [">= 0"])
      s.add_development_dependency(%q<guard>, [">= 0"])
      s.add_development_dependency(%q<guard-test>, [">= 0"])
      s.add_development_dependency(%q<rb-fsevent>, [">= 0"])
    else
      s.add_dependency(%q<uuidtools>, [">= 0"])
      s.add_dependency(%q<activeuuid>, [">= 0"])
      s.add_dependency(%q<simplecov>, [">= 0"])
      s.add_dependency(%q<jeweler>, [">= 0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<rdoc>, [">= 0"])
      s.add_dependency(%q<guard>, [">= 0"])
      s.add_dependency(%q<guard-test>, [">= 0"])
      s.add_dependency(%q<rb-fsevent>, [">= 0"])
    end
  else
    s.add_dependency(%q<uuidtools>, [">= 0"])
    s.add_dependency(%q<activeuuid>, [">= 0"])
    s.add_dependency(%q<simplecov>, [">= 0"])
    s.add_dependency(%q<jeweler>, [">= 0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<rdoc>, [">= 0"])
    s.add_dependency(%q<guard>, [">= 0"])
    s.add_dependency(%q<guard-test>, [">= 0"])
    s.add_dependency(%q<rb-fsevent>, [">= 0"])
  end
end

