require 'rubygems'
require 'active_record'

module DOM

    class Platform < ActiveRecord::Base
        has_many :machines

        def self.get_by_name(name)
            p = self.find_by_name(name)

            if p.nil? then
                p = self.new(:name => name)
                p.save
            end

            return p
        end
    end

    class Manufacturer < ActiveRecord::Base
        has_many :devices

        def self.get_by_name(name)
            m = self.find_by_name(name)

            if m.nil? then
                m = self.new(:name => name)
                m.save
            end

            return m
        end
    end

    class DeviceType < ActiveRecord::Base
        has_many :devices

        def self.get_by_name(name)
            dt = self.find_by_name(name)

            if dt.nil? then
                dt = self.new(:name => name)
                dt.save
            end

            return dt
        end
    end

    class Machine < ActiveRecord::Base
        belongs_to :platform
        has_and_belongs_to_many :devices, :join_table => 'connected_devices'
    end

    class Device < ActiveRecord::Base
        belongs_to :platform
        belongs_to :manufacturer
        belongs_to :device_type
        has_and_belongs_to_many :machines, :join_table => 'connected_devices'
    end

end
