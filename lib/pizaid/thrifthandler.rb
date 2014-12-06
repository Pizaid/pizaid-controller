require_relative 'network'
require_relative 'storage'
require_relative 'power'

module Pizaid
  module Controller
    class ThriftHandler
      def initialize
        @network = Network.new
        @storage = Storage.new
        @power = Power.new
      end
      def network_ipv4()
        @network.ipv4
      end
      def network_ipv6()
        @network.ipv6
      end

      def storage_storage_group_list()
        @storage.storageGroupList
      end
      def storage_capacity_kb(key)
        @storage.capacityKB(key)
      end
      def storage_usage_kb(key)
        @storage.usageKB(key)
      end
      def storage_usage_percent(key)
        @storage.usagePercent(key)
      end
      def storage_is_sync()
        @storage.isSync
      end
      def storage_join(key, disk)
        @storage.join(key, disk)
      end
      def storage_disk_list(key)
        @storage.diskList(key)
      end
      def storage_disk_id(disk)
        @storage.diskID(disk)
      end
      def storage_disk_size(disk)
        @storage.diskSize(disk)
      end
      def storage_disk_port(disk)
        @storage.diskPort(disk)
      end
      
      def power_battery_percent()
        @power.batteryPercent()
      end
      def power_is_ac_plugin()
        @power.isACPlugin()
      end
    end
  end
end
