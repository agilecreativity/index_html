# A sample Guardfile
# More info at https://github.com/guard/guard#readme
guard :rspec, cmd: "bundle exec rspec" do
  watch(%r{^lib/(.+)\.rb$})            { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch(%r{^lib/index_html/(.+)\.rb$}) { |m| "spec/lib/index_html/#{m[1]}_spec.rb" }
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^spec/support/(.+)\.rb$})   { 'spec' }
  watch('spec/spec_helper.rb')         { 'spec' }
end
