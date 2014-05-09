require 'bundler/gem_tasks'
Bundler::GemHelper.install_tasks

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task default: :spec

task :pry do
  require 'pry'
  require 'awesome_print'
  require 'index_html'
  include IndexHtml
  ARGV.clear
  Pry.start
end
