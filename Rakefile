require 'rake/testtask'

Rake::TestTask.new(:test) do |t|
  t.libs << "t"
  t.test_files = FileList['t/test*.rb']
  t.verbose = true
end

Rake::TestTask.new(:test_unit) do |t|
  t.libs << "t"
  t.test_files = FileList['t/test_unit.rb']
  t.verbose = true
end

Rake::TestTask.new(:test_func) do |t|
  t.libs << "t"
  t.test_files = FileList['t/test_func.rb']
  t.verbose = true
end

desc "Install gems"
task :install do
  sh 'bundle install'
end

desc "Initialize service"
task :init do
  sh 'god -c config.god'
end

desc "Run service"
task :start do
  sh 'god start alreadycracked'
end

desc "Stop service"
task :stop do
  sh "god stop alreadycracked"
end

desc "Deploy to Azure"
task :deploy_az do
  sh "bash scripts/az-deploy.sh"
end

desc "Purge from Azure"
task :purge_az do
  sh "bash scripts/az-purge.sh"
end

desc "Deploy to Heroku"
task :deploy_heroku do
  sh "bash scripts/heroku-deploy.sh"
end

desc "Purge from Heroku"
task :purge_heroku do
  sh "bash scripts/heroku-purge.sh"
end

task :default => :init
