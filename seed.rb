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
        machines_id = @DB[:machines].insert :call_sign => "goose",:ip_address => "172.20.160.147",:platform_id => ios_id,:port => "9099"

        # =====================
        # = Connected Devices =
        # =====================
        @DB[:connected_devices].insert :machines_id => machines_id,:devices_id => iphone_id
        @DB[:connected_devices].insert :machines_id => machines_id,:devices_id => tablet_id

        # ========
        # = Jobs =
        # ========
        time_near_future = Time.now.to_i + 180

        @DB[:jobs].insert :name => "hudsoniPhoneExample",:machines_id => machines_id,:command => "mkdir -p hudsoniphoneexample; cd hudsoniphoneexample; pwd; git clone git@github.com:AlexsJones/Hudson-Integration.git .; cd ../; rm -rf hudsoniphoneexample;",:status => "INCOMPLETE",:trigger_time => time_near_future.to_s

        puts "Seed done"
    end
end  



