require 'rubygems'
require 'rake'
require 'rake/testtask'

desc "Run all our tests"
task :test do
  Rake::TestTask.new do |t|
    t.libs << "seed"
    t.libs << "tests"
    t.pattern = "tests/**/*.rb"
    t.verbose = false
  end
end


namespace :DB do
  
  desc "init"
  task :init do
    system("cd database/migrations/ && ant clean")
  end
  desc "migrate"
  task :migrate do
    system("cd database/migrations/ && ./migrate")
  end
end  

task :default => "test"
