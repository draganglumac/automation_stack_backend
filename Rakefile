require 'rubygems'
require 'rake'
require 'rake/testtask' 
require 'sequel'
require_relative 'database/hook' 


ENV["DATABASE"] = "AUTOMATION.TEST"
ENV["HOST"] = "10.65.80.46"
ENV["USERNAME"] = "dummy"
ENV["PASSWORD"] = "dummy"


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
    if DB[:changelog].exists
      puts "database already initialised!"
    else
      system("cd database/migrations/ && ant clean") 
    end                                                     
  end
  desc "migrate"
  task :migrate do    
    system("cd database/migrations/ && ./migrate")
  end
end  

task :default => "test"
