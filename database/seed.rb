require 'rubygems'
require "pry"
require "sequel" 

class Seed
  
  def self.run
              
    # =============
    # = platforms =
    # =============

    ios_id= DB[:platform].insert :name => "ios"
    DB[:platform].insert :name => "android"


    # ===========
    # = Devices =
    # ===========
    iphone_id = DB[:devices].insert :model => "iphone4",:serial_number => "apple001",:platform_id => ios_id,:type => "phone" 
    tablet_id = DB[:devices].insert :model => "ipad",:serial_number => "apple002",:platform_id => ios_id ,:type => "tablet"   

    # ============
    # = machines =
    # ============
    machines_id = DB[:machines].insert :call_sign => "goose",:ip_address => "127.0.0.1",:platform_id => ios_id,:port => "9099"

    # =====================
    # = Connected Devices =
    # =====================
    DB[:connected_devices].insert :machines_id => machines_id,:devices_id => iphone_id
    DB[:connected_devices].insert :machines_id => machines_id,:devices_id => tablet_id
     
    # ========
    # = Jobs =
    # ========
    DB[:jobs].insert :name => "job_name",:machines_id => machines_id,:command => "echo hello",:status => "INCOMPLETE",:trigger_time => "1000-01-01 00:00:00"
  end
end  
           
if __FILE__ == $0
    
  DB = Sequel.mysql2(ENV["AUTOMATION_STACK_DATABASE"],:host =>ENV["AUTOMATION_STACK_DATABASE_HOST"],:username => ENV["AUTOMATION_STACK_DATABASE_USERNAME"],:password =>ENV["AUTOMATION_STACK_DATABASE_PASSWORD"])
  
  Seed.run
  
  puts "seed ok!"
end

                        
