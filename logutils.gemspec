# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "logutils"
  s.version = "0.4.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Gerald Bauer"]
  s.date = "2013-02-23"
  s.description = "Another Logger"
  s.email = "opensport@googlegroups.com"
  s.extra_rdoc_files = ["Manifest.txt"]
  s.files = ["History.md", "Manifest.txt", "README.md", "Rakefile", "lib/logutils.rb", "lib/logutils/db.rb", "lib/logutils/db/deleter.rb", "lib/logutils/db/models.rb", "lib/logutils/db/schema.rb", "lib/logutils/logger.rb", "lib/logutils/version.rb", "test/test.rb", "test/test_helper.rb", "test/test_logger.rb", ".gemtest"]
  s.homepage = "https://github.com/geraldb/logutils"
  s.licenses = ["Public Domain"]
  s.rdoc_options = ["--main", "README.md"]
  s.require_paths = ["lib"]
  s.required_ruby_version = Gem::Requirement.new(">= 1.9.2")
  s.rubyforge_project = "logutils"
  s.rubygems_version = "1.8.17"
  s.summary = "Another Logger"
  s.test_files = ["test/test_helper.rb", "test/test_logger.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_development_dependency(%q<hoe>, ["~> 3.3"])
    else
      s.add_dependency(%q<rdoc>, ["~> 3.10"])
      s.add_dependency(%q<hoe>, ["~> 3.3"])
    end
  else
    s.add_dependency(%q<rdoc>, ["~> 3.10"])
    s.add_dependency(%q<hoe>, ["~> 3.3"])
  end
end
