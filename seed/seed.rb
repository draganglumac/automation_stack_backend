require 'active_record'
require_relative 'csv_processor'

module Seed

    def self.run
        processor = CSVProcessor.new
        processor.load_machines
        processor.load_devices

        if processor.machines.empty? and processor.devices.empty? then 
            puts "Database was not seeded as no seed data was found."
            exit 0
        end

        puts "Warning! Seed data does not contain any machines." if processor.machines.empty?
        puts "Warning! Seed data does not contain any devices." if processor.devices.empty?

        # First, hook up active record to the database
        db_conn = ActiveRecord::Base.establish_connection(
            :adapter => 'mysql',
            :host => processor.conf['AUTOMATION_HOST'],
            :database => processor.conf['AUTOMATION_DB'],
            :username => processor.conf['AUTOMATION_USER'],
            :password => processor.conf['AUTOMATION_PASS']
        )

        # Then load the model so that it binds tables to the classes
        require_relative 'dom'

        # Process machines
        processor.seed_machines
        processor.seed_devices

        db_conn.disconnect!
    end

end
