require 'rubygems'
require "sequel"
require 'mysql2'
                    


def reset(data_base,host,username,password)
  client = Mysql2::Client.new(:host =>host, :username => username, :password =>password)
  client.query("DROP DATABASE IF EXISTS #{data_base}")
  client.query("CREATE DATABASE #{data_base}")
  client.close
end

                                  
begin
  DB = Sequel.mysql2(ENV["DATABASE"],:host => ENV["HOST"],:username => ENV["USERNAME"],:password => ENV["PASSWORD"])
  DB.test_connection() 
rescue Sequel::DatabaseConnectionError => e
  if e.message.include? "Unknown database 'AUTOMATIONTEST'"
    reset(ENV["DATABASE"],ENV["HOST"],ENV["USERNAME"],ENV["PASSWORD"])
  end
end
           
if __FILE__ == $0 
  reset if ARGV[0] == "--reset" 
  puts "initialised ok!"
end