require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << "t"
  t.test_files = FileList['t/test*.rb']
  t.verbose = true
end

task :default => :test
