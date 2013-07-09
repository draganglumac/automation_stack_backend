require "riot"  
require "logger"

require 'pry'

require "sequel"
require "mysql2"

require_relative "test_data.rb"

context "Database" do
  
  helper(:config){YAML.load_file("settings.yaml")}            
  helper(:ds){Sequel.mysql2(config["AUTOMATION_DB"],:host => config["AUTOMATION_HOST"],:username => config["AUTOMATION_USER"],:password => config["AUTOMATION_PASS"])}
  helper(:dc) { Mysql2::Client.new(:host => config["AUTOMATION_HOST"], :username => config["AUTOMATION_PASS"], :password => config["AUTOMATION_USER"], :database => config["AUTOMATION_DB"], :async => true,:flags => Mysql2::Client::MULTI_STATEMENTS ) }
  
  hookup do
    `rake reset`
  end
  context "Stored Procedures" do 

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
    context "update_machine_status" do
		asserts("ok") do
		dc.query("CALL update_machine_status('172.20.160.147','ONLINE')")
		ds[:machines].where(:status => 'ONLINE').count==1
		end
	end
	context "get_candidate_jobs" do
      asserts("ok") {dc.query("Call get_candidate_jobs()").count > 0}
    end
  end

  context "update_job_run_time" do
    asserts("ok") do
      runtime = dc.query("select `trigger_time` from `jobs` where `id` = 1;").first["trigger_time"]
      dc.query("call update_job_run_time(1);")
      newtime = dc.query("select `trigger_time` from `jobs` where `id` = 1;").first["trigger_time"]
      runtime == newtime

      runtime = dc.query("select `trigger_time` from `jobs` where `id` = 2;").first["trigger_time"]
      dc.query("call update_job_run_time(2);")
      newtime = dc.query("select `trigger_time` from `jobs` where `id` = 2;").first["trigger_time"]
      newtime == runtime + 3600
    end
  end 
end   

