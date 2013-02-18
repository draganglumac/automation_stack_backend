require 'rubygems'
require "pry"
require "sequel"                               
 
 
 
DB = Sequel.mysql2("AUTOMATION",:host => "10.65.80.46",:username => "dummy",:password => "dummy")
 
# =============
# = platforms =
# =============
 
ios_id = DB[:platform].insert :name => "ios"
android_id = DB[:platform].insert :name => "android"
 
 
# ===========
# = Devices =
# ===========
iphone_id = DB[:devices].insert :model => "iphone4",:serial_number => "apple001",:platform_id => ios_id,:type => "phone" 
DB[:devices].insert :model => "ipad",:serial_number => "apple002",:platform_id => ios_id ,:type => "tablet"   
 
# ============
# = machines =
# ============
machines_id = DB[:machines].insert :call_sign => "maverick",:ip_address => "127.0.0.1",:platform_id => ios_id
 
# =====================
# = Connected Devices =
# =====================
DB[:connected_devices].insert :machines_id => machines_id,:devices_id => iphone_id
 
# ========
# = Jobs =
# ========
DB[:jobs].insert :name => "job_name",:machines_id => machines_id,:command => "echo hello",:status => "INCOMPLETE"