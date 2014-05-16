# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "index_html/version"

Gem::Specification.new do |spec|
  spec.name          = "index_html"
  spec.version       = IndexHtml::VERSION
  spec.authors       = ["Burin Choomnuan"]
  spec.email         = ["agilecreativity@gmail.com"]
  spec.description   = %q(Generate the index.html from list of files)
  spec.summary       = %q(Generate simple index.html from list of files based on simple criteria)
  spec.homepage      = "https://github.com/agilecreativity/index_html"
  spec.license       = "MIT"
  spec.files         = Dir.glob("{bin,lib}/**/*") + %w[Gemfile
                                                       Rakefile
                                                       index_html.gemspec
                                                       README.md
                                                       CHANGELOGS.md
                                                       LICENSE
                                                       .rubocop.yml
                                                       .gitignore]
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]
  spec.add_runtime_dependency "thor", "~> 0.19"
  spec.add_runtime_dependency "agile_utils", "~> 0.1"
  spec.add_runtime_dependency "code_lister", "~> 0.1"
  spec.add_development_dependency "awesome_print", "~> 1.2"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "fuubar", "~> 1.3"
  spec.add_development_dependency "guard-rspec", "~> 4.2"
  spec.add_development_dependency "pry", "~> 0.9"
  spec.add_development_dependency "rake", "~> 10.3"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "rubocop", "~> 0.20"
  spec.add_development_dependency "coveralls", "~> 0.7"
end
