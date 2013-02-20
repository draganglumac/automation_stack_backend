require 'rubygems'
require 'rake'   
require 'mysql2'
require 'rake/testtask' 
require 'sequel'
 


ENV["DATABASE"] = "AUTOMATIONTEST"
ENV["HOST"] = "10.65.80.46"
ENV["USERNAME"] = "dummy"
ENV["PASSWORD"] = "dummy"


DB = Sequel.mysql2(ENV["DATABASE"],:host => ENV["HOST"],:username => ENV["USERNAME"],:password => ENV["PASSWORD"])

namespace :test do
  desc "Run all our tests"
  task :run do
    Rake::TestTask.new do |t|
      t.libs << "seed"
      t.libs << "tests"
      t.pattern = "tests/**/*.rb"
      t.verbose = true
    end
  end
end

namespace :db do 
  desc "drop"
  task :drop do
    client = Mysql2::Client.new(:host =>ENV["HOST"], :username =>ENV["USERNAME"], :password =>ENV["PASSWORD"])
    client.query("DROP DATABASE IF EXISTS #{ENV["DATABASE"]};")
    client.close
  end                                                          
  
  desc "create"
  task :create do
    client = Mysql2::Client.new(:host =>ENV["HOST"], :username =>ENV["USERNAME"], :password =>ENV["PASSWORD"])
    client.query("CREATE DATABASE #{ENV["DATABASE"]};")
    client.close
  end 
  
  desc "seed"
  task :seed do
    system("cd database && ruby seed.rb")
  end          
  
  desc "Reset"
  task :reset do
    Rake::Task['db:drop'].execute
    Rake::Task['db:create'].execute
    Rake::Task['db:create'].execute
  end
  desc "setup"
  task :setup do  
    
    begin
      DB.test_connection() 
    rescue Sequel::DatabaseConnectionError => e
      Rake::Task['db:drop'].execute
      Rake::Task['db:create'].execute 
    end
    
    system("cd database/migrations/ && ant clean")
    
  end
  desc "migrate"
  task :migrate do    
    system("cd database/migrations/ && ant update-database")
  end
end  

task :default => "test:run"
