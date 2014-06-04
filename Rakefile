require "bundler/gem_tasks"
Bundler::GemHelper.install_tasks

require "rspec/core/rake_task"
RSpec::Core::RakeTask.new(:spec)
task default: :spec

task :pry do
  require "pry"
  require "awesome_print"
  require "index_html"
  include IndexHtml
  ARGV.clear
  Pry.start
end

require "rubocop/rake_task"
desc "Run RuboCop on the lib directory"
RuboCop::RakeTask.new(:rubocop) do |task|
  task.patterns = ["lib/**/*.rb"]
  # only show the files with failures
  task.formatters = ["files"]
  # don't abort rake on failure
  task.fail_on_error = false
end
