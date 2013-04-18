require 'rubygems'
require 'active_record'
require 'yaml'
require 'csv'

class CSVProcessor

    attr_reader :conf
    attr_reader :machines
    attr_reader :devices

    def initialize(conf_filepath="")
        @root_dir = File.join(File.dirname(File.expand_path('__FILE__')))

        conf_filepath = File.join(@root_dir, 'settings.yaml') if conf_filepath.empty?       

        @conf = YAML::load_file(File.open(conf_filepath))
        @platforms = []
        @manufacturers = []
        @device_types = []
        @machines = []
        @devices = []
    end

    def load_platforms(seed_dir="")
        seed_conf = @conf['SEED_CONFIG']
        return if seed_conf.empty?

        seed_dir = File.join(@root_dir, 'database/seed') if seed_dir.empty?

        File.open("#{seed_dir}/#{seed_conf}/platforms.csv").each do |line|
            @platforms << CSV.parse(line).first unless line.strip.empty? or line.strip.start_with?("#")
        end
    end

    def load_manufacturers(seed_dir="")
        seed_conf = @conf['SEED_CONFIG']
        return if seed_conf.empty?

        seed_dir = File.join(@root_dir, 'database/seed') if seed_dir.empty?

        File.open("#{seed_dir}/#{seed_conf}/manufacturers.csv").each do |line|
            @manufacturers << CSV.parse(line).first unless line.strip.empty? or line.strip.start_with?("#")
        end
    end

    def load_device_types(seed_dir="")
        seed_conf = @conf['SEED_CONFIG']
        return if seed_conf.empty?

        seed_dir = File.join(@root_dir, 'database/seed') if seed_dir.empty?

        File.open("#{seed_dir}/#{seed_conf}/device_types.csv").each do |line|
            @device_types << CSV.parse(line).first unless line.strip.empty? or line.strip.start_with?("#")
        end
    end

    def load_machines(seed_dir="")
        seed_conf = @conf['SEED_CONFIG']
        return if seed_conf.empty?

        seed_dir = File.join(@root_dir, 'database/seed') if seed_dir.empty?

        File.open("#{seed_dir}/#{seed_conf}/machines.csv").each do |line|
            @machines << CSV.parse(line).first unless line.strip.empty? or line.strip.start_with?("#")
        end
    end

    def load_devices(seed_dir="")
        seed_conf = @conf['SEED_CONFIG']
        return if seed_conf.empty?

        seed_dir = File.join(@root_dir, 'database/seed') if seed_dir.empty?

        File.open("#{seed_dir}/#{seed_conf}/devices.csv").each do |line|
            @devices << CSV.parse(line).first unless line.strip.empty? or line.strip.start_with?("#")
        end
    end

    def seed_platforms
        return if @platforms.empty? or not defined?(DOM)

        keys = []
        @platforms.first.each do |key|
            keys << key.to_sym
        end
        @platforms[0] = keys

        maps = []
        @platforms.each do |m|
            if m != @platforms.first then
                maps << Hash[@platforms.first.zip m]
            end
        end

        maps.each do |mp|
            p = DOM::Platform.new(mp)
            p.save
        end
    end

    def seed_manufacturers
        return if @manufacturers.empty? or not defined?(DOM)

        keys = []
        @manufacturers.first.each do |key|
            keys << key.to_sym
        end
        @manufacturers[0] = keys

        maps = []
        @manufacturers.each do |m|
            if m != @manufacturers.first then
                maps << Hash[@manufacturers.first.zip m]
            end
        end

        maps.each do |mmf|
            mf = DOM::Manufacturer.new(mmf)
            mf.save
        end
    end

    def seed_device_types
        return if @device_types.empty? or not defined?(DOM)

        keys = []
        @device_types.first.each do |key|
            keys << key.to_sym
        end
        @device_types[0] = keys

        maps = []
        @device_types.each do |m|
            if m != @device_types.first then
                maps << Hash[@device_types.first.zip m]
            end
        end

        maps.each do |mdt|
            dt = DOM::DeviceType.new(mdt)
            dt.save
        end
    end

    def seed_machines
=begin
    This is a bit ugly :-(!

    We cannot just require 'dom' here because we may not have connected
    ActiveRecord::Base to the database yet. If we did that the program
    would blow up as all DOM classes inherit from ActiveRecord::Base,
    and in order for the mapping to succeed we need to have established
    a connection to the database.

    So the best we can do is return if DOM module is not already loaded 
    into the environment prior to calling this function.
=end

        return if @machines.empty? or not defined?(DOM)

        keys = [] 
        @machines.first.each do |key|
            keys << key.to_sym
        end
        @machines[0] = keys

        maps = []
        @machines.each do |m|
            if m != @machines.first then
                maps << Hash[@machines.first.zip m]
            end
        end

        maps.each do |mm|
            # Platform is the only dependency
            p = DOM::Platform.get_by_name(mm[:platform]) 
            mm.delete(:platform)

            machine = DOM::Machine.new(mm)
            machine.platform = p
            machine.save
        end
    end

    def seed_devices
=begin
    Same comment as for seed_machines.

    We cannot just require 'dom' here because we may not have connected
    ActiveRecord::Base to the database yet. If we did that the program
    would blow up as all DOM classes inherit from ActiveRecord::Base,
    and in order for the mapping to succeed we need to have established
    a connection to the database.

    So the best we can do is return if DOM module is not already loaded 
    into the environment prior to calling this function.
=end
        return if @devices.empty? or not defined?(DOM)

        keys = []
        @devices.first.each do |key|
            keys << key.to_sym
        end
        @devices[0] = keys

        maps = []
        @devices.each do |d|
            if d != @devices.first then
                maps << Hash[@devices.first.zip d]
            end
        end

        maps.each do |md|
            # Dependencies
            p = DOM::Platform.get_by_name(md[:platform])
            md.delete(:platform)

            mf = DOM::Manufacturer.get_by_name(md[:manufacturer])
            md.delete(:manufacturer)

            dt = DOM::DeviceType.get_by_name(md[:device_type])
            md.delete(:device_type)

            on_node = nil
            if not md[:machine].nil? and not md[:machine].empty? then
                on_node = DOM::Machine.find_by_call_sign(md[:machine])
            end
            md.delete(:machine)

            device = DOM::Device.new(md)
            device.platform = p
            device.manufacturer = mf
            device.device_type = dt
            if not on_node.nil? then
                device.machines << on_node
            end
            device.save
        end
    end

end

