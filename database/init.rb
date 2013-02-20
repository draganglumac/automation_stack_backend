require 'rubygems'
require "pry"
require "sequel"
require 'mysql2'
                    


def reset(data_base)
  client = Mysql2::Client.new(:host => ENV["HOST"], :username => ENV["USER"], :password =>ENV["PASSWORD"])
  client.query("DROP DATABASE IF EXISTS #{data_base}")
  client.query("CREATE DATABASE #{data_base}")
  client.close
end

                                  
begin
  DB = Sequel.mysql2("AUTOMATIONTEST",:host => "10.65.80.46",:username => "dummy",:password => "dummy")
  DB.test_connection() 
rescue Sequel::DatabaseConnectionError => e
  if e.message.include? "Unknown database 'AUTOMATIONTEST'"
    reset
  end
end
           
if __FILE__ == $0 
  reset if ARGV[0] == "-r" 
  puts "built ok!"
end