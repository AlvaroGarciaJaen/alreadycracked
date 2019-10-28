require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << "t"
  t.test_files = FileList['t/test_func.rb']
  t.verbose = true
end

desc "Run service"
task :start do
  sh 'rackup -D'
end

desc "Stop service"
task :stop do
  pid = `lsof -i :9292 -sTCP:LISTEN -t`
  sh "kill -9 #{pid}"
end

task :default => :start
