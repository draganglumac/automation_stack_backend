require "riot"  
require "logger"

require 'pry'

require "sequel"
require "mysql2"

require_relative "../seed.rb"

context "Database" do
  
  helper(:config){YAML.load_file("settings.yaml")}            
  helper(:ds){Sequel.mysql2(config["AUTOMATION_DB"],:host => config["AUTOMATION_HOST"],:username => config["AUTOMATION_USER"],:password => config["AUTOMATION_PASS"])}
  helper(:dc) { Mysql2::Client.new(:host => config["AUTOMATION_HOST"], :username => config["AUTOMATION_PASS"], :password => config["AUTOMATION_USER"], :database => config["AUTOMATION_DB"], :async => true,:flags => Mysql2::Client::MULTI_STATEMENTS ) }
  
  hookup do
    `rake reset`
  end
  
  context "Stored Procedures" do 

    context "get_incomplete_jobs" do
      asserts("ok") {dc.query( 'CALL get_incomplete_jobs()').count==1}
    end                      
    
    context "get_machine_ip_from_id" do
      asserts("ok") do
        dc.query( "CALL get_machine_ip_from_id(1)").first["ip_address"]  == "172.20.160.147"
      end
    end                                            
    
    context "set_job_status_from_id" do
      asserts("ok") do
        dc.query("CALL set_job_status_from_id(1,'INPROGRESS')")
        ds[:jobs].where(:status => "INPROGRESS").count==1
      end

    end 
    
    context "get_all_jobs" do
      asserts("ok") {dc.query("Call get_jobs_all()").count > 0}
    end
  end
end   

