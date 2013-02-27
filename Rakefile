require 'rubygems'
require 'rake'   
require 'mysql2'
require 'rake/testtask' 
require 'sequel'
require 'yaml'

db_config = YAML.load_file("settings.yaml")
puts db_config["AUTOMATION_HOST"]
puts db_config["AUTOMATION_DB"]
puts db_config["AUTOMATION_USER"]
puts db_config["AUTOATION_PASS"]

client = Mysql2::Client.new(:host => db_config["AUTOMATION_HOST"],:username => db_config["AUTOMATION_USER"],:password => db_config["AUTOMATION_PASS"])
task :drop do
    client.query("DROP DATABASE IF EXISTS #{db_config['AUTOMATION_DB']};")
end
task :create do
    client.query("CREATE DATABASE #{db_config['AUTOMATION_DB']};")
end
task :migrate do
    puts "Migrating"
    Dir.chdir("database/migrations/") do
        system("ant create-changelog-table && ant update-database")
    end
end
at_exit do
    client.close()
end

task :default => [:drop,:create, :migrate]
