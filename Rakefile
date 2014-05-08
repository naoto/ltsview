#!/usr/bin/env rake
require 'bundler/gem_tasks'

# RSpec
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = 'spec/ltsview/*_spec.rb'
end
task :default => :spec
