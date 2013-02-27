require 'rubygems'
require "pry"
require "sequel" 
require 'yaml'


db_config = YAML.load_file("settings.yaml")

class Seed

    def self.run(db,host,username,password)

        @DB = Sequel.mysql2(db,:host => host,:username =>username,:password => password)

        # =============
        # = platforms =
        # =============

        ios_id= @DB[:platform].insert :name => "ios"
        @DB[:platform].insert :name => "android"


        # ===========
        # = Devices =
        # ===========
        iphone_id = @DB[:devices].insert :model => "iphone4",:serial_number => "apple001",:platform_id => ios_id,:type => "phone" 
        tablet_id = @DB[:devices].insert :model => "ipad",:serial_number => "apple002",:platform_id => ios_id ,:type => "tablet"   

        # ============
        # = machines =
        # ============
        machines_id = @DB[:machines].insert :call_sign => "goose",:ip_address => "127.0.0.1",:platform_id => ios_id,:port => "9099"

        # =====================
        # = Connected Devices =
        # =====================
        @DB[:connected_devices].insert :machines_id => machines_id,:devices_id => iphone_id
        @DB[:connected_devices].insert :machines_id => machines_id,:devices_id => tablet_id

        # ========
        # = Jobs =
        # ========
        @DB[:jobs].insert :name => "job_name",:machines_id => machines_id,:command => "echo hello",:status => "INCOMPLETE",:trigger_time => "1361950421"
        puts "Seed done"
    end
end  



