#!/usr/bin/env rake
require 'bundler/gem_tasks'

# RSpec
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  if RUBY_VERSION < '1.9'
    spec.pattern = 'spec/ltsview187/*_spec.rb'
  else
    spec.pattern = 'spec/ltsview/*_spec.rb'
  end
end
task :default => :spec
