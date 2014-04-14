require "bundler/gem_tasks"
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec

task :irb do
  require 'irb'
  require 'awesome_print'
  require 'irb/completion'
  require 'index_html'
  include FileIndexer
  ARGV.clear
  IRB.start
end

task :pry do
  require 'pry'
  require 'awesome_print'
  require 'index_html'
  include FileIndexer
  ARGV.clear
  Pry.start
end
