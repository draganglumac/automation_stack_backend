require 'rubygems'
require 'rake'   
require 'mysql2'
require 'rake/testtask' 
require 'sequel'
 



ENV["AUTOMATION_STACK_DATABASE_HOST"] = "10.65.80.46"
ENV["AUTOMATION_STACK_DATABASE_USERNAME"] = "dummy"
ENV["AUTOMATION_STACK_DATABASE_PASSWORD"] = "dummy"


DB = Sequel.mysql2(ENV["AUTOMATION_STACK_DATABASE"],:host => ENV["AUTOMATION_STACK_DATABASE_HOST"],:username => ENV["AUTOMATION_STACK_DATABASE_USERNAME"],:password => ENV["AUTOMATION_STACK_DATABASE_PASSWORD"])




desc "setup"
task :setup do  
  Rake::Task['db:drop'].execute
  Rake::Task['db:create'].execute
  Rake::Task['db:init'].execute
  Rake::Task['db:migrate'].execute
  Rake::Task['db:seed'].execute
end

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
  namespace :db do
    desc "setup"
    task :setup do
      
      ENV["AUTOMATION_STACK_DATABASE"] = "AUTOMATIONTEST"
      Rake::Task['setup'].execute


      puts "setup and seeded #{ENV["AUTOMATION_STACK_DATABASE"]} database"
    end
  end
  
end

namespace :db do 

  
  
  desc "drop"
  task :drop do
    client = Mysql2::Client.new(:host =>ENV["AUTOMATION_STACK_DATABASE_HOST"], :username =>ENV["AUTOMATION_STACK_DATABASE_USERNAME"], :password =>ENV["AUTOMATION_STACK_DATABASE_PASSWORD"])
    client.query("DROP DATABASE IF EXISTS #{ENV["AUTOMATION_STACK_DATABASE"]};")
    client.close
  end                                                          
  
  desc "create"
  task :create do
    client = Mysql2::Client.new(:host =>ENV["AUTOMATION_STACK_DATABASE_HOST"], :username =>ENV["AUTOMATION_STACK_DATABASE_USERNAME"], :password =>ENV["AUTOMATION_STACK_DATABASE_PASSWORD"])
    client.query("CREATE DATABASE #{ENV["AUTOMATION_STACK_DATABASE"]};")
    client.close
  end 
  
  desc "seed"
  task :seed do
    system("cd database && ruby seed.rb")
  end          
  
  desc "setup"
  task :setup do
    ENV["AUTOMATION_STACK_DATABASE"] = "AUTOMATIONLIVE"
    Rake::Task['setup'].execute
    puts "setup and seeded #{ENV["AUTOMATION_STACK_DATABASE"]} database"
  end
  desc "init"
  task :init do  
    
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
  