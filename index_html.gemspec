# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'index_html/version'

Gem::Specification.new do |spec|
  spec.name          = "index_html"
  spec.version       = IndexHtml::VERSION
  spec.authors       = ["Burin Choomnuan"]
  spec.email         = ["agilecreativity@gmail.com"]
  spec.description   = %q{Generate the index.html from list of files}
  spec.summary       = %q{Generate simple index.html from list of files}
  spec.homepage      = "https://github.com/agilecreativity/index_html"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "code_lister", "~> 0.0.6"
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 2.14"
  spec.add_development_dependency "guard-rspec", "~> 4.2"
  spec.add_development_dependency "awesome_print", "~> 1.2"
  spec.add_development_dependency "pry", "~> 0.9"
  spec.add_development_dependency "fuubar", "~> 1.3"

end
