# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'ltsview/version'

Gem::Specification.new do |gem|
  gem.name          = "ltsview"
  gem.version       = Ltsview::VERSION
  gem.authors       = ["Naoto SHINGAKI"]
  gem.email         = ["n.shingaki@gmail.com"]
  gem.description   = %q{Ltsview - Labeled Tab Separated Value manipulator Viewer}
  gem.summary       = %q{Ltsview - Labeled Tab Separated Value manipulator Viewer}
  gem.homepage      = "https://github.com/naoto/ltsview"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.add_runtime_dependency 'ltsv'
  gem.add_runtime_dependency 'coderay'
  gem.add_runtime_dependency 'json' if RUBY_VERSION < '1.9'

  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'rspec'

  gem.add_development_dependency 'coveralls'


end
