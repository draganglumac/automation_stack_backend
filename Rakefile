require 'rubygems'

require 'mysql2' 
require 'sequel'

require 'yaml'


require 'rake'
require 'rake/testtask'


db_config = YAML.load_file("settings.yaml")
puts db_config["AUTOMATION_HOST"]
puts db_config["AUTOMATION_DB"]
puts db_config["AUTOMATION_USER"]
puts db_config["AUTOATION_PASS"]
puts db_config["SEED_CONFIG"]

client = Mysql2::Client.new(:host => db_config["AUTOMATION_HOST"],:username => db_config["AUTOMATION_USER"],:password => db_config["AUTOMATION_PASS"])

task :drop do
    client.query("DROP DATABASE IF EXISTS #{db_config['AUTOMATION_DB']};")
end
task :create do
    client.query("CREATE DATABASE #{db_config['AUTOMATION_DB']};")
end


Rake::TestTask.new(:verify) do |t|
    t.test_files = FileList['test/*_test.rb']
    t.verbose = true
end



desc "reset"
task :reset => [:drop,:create,:setup,:populate_test_data] do
end

desc 'Migrate the database'
task :migrate do
    puts "Migrating"
    Dir.chdir("database/migrations/") do
        system("ant update-database")
    end
end

desc 'setup the database'
task :setup do
    puts "Migrating"
    Dir.chdir("database/migrations/") do
        system("ant create-changelog-table && ant update-database")
    end
end


desc 'Populate with test data'
task :populate_test_data do
    require_relative 'test/test_data.rb'
    TestSeed.run(db_config["AUTOMATION_DB"],db_config["AUTOMATION_HOST"],db_config["AUTOMATION_USER"],db_config["AUTOMATION_PASS"]) 
end

desc "seed"
task :seed => [:drop,:create,:setup,:seed_db] do
end

desc 'Seed the database'
task :seed_db do
    require_relative 'seed/seed'
    Seed.run
end

at_exit do
    client.close
end

task :default => [:drop,:create,:setup,:seed]
