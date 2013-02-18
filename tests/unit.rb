require "riot"  
require "logger"

require "sequel"
require "mysql2"

context "Database" do            
  helper(:ds){Sequel.mysql2("AUTOMATION",:host => "10.65.80.46",:username => "dummy",:password => "dummy")}
  helper(:dc) { Mysql2::Client.new(:host =>'10.65.80.46', :username => "dummy", :password => 'dummy', :database => 'AUTOMATION', :async => true,:flags => Mysql2::Client::MULTI_STATEMENTS ) }
  hookup do
    
  end
  
  context "Stored Procedures" do 
    context "get_incompleete_jobs" do
      asserts("ok") {dc.query( 'CALL get_incompleete_jobs()')}
    end                      
    
    context "get_machine_ip_from_id" do
      asserts("ok") {dc.query( "CALL get_machine_ip_from_id(1)")}
    end                                            
    
    context "set_job_status_from_id" do
      asserts("ok") {dc.query("CALL set_job_status_from_id('INPROGRESS',1)").nil? }
    end 
    
    context "get_all_jobs" do
      asserts("ok") {dc.query("Call get_jobs_all()")}
    end
    
    context "add_result_from_job" do
      asserts("ok") { dc.query("Call add_result_from_job(1,'<html></html>')") }
    end
  end
end