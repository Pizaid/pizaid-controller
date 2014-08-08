require_relative 'network'
require_relative 'storage'
require_relative 'power'

module Pizaid
  module Controller
    class ThriftHander
      def initialize
        @network = Network.new
        @storage = Storage.new
        @power = Power.new
      end
      def network_get_ipv4()
        puts "network: #{@network.get_ipv4}"
        @network.get_ipv4
      end
      def network_get_ipv6()
        @network.get_ipv6
      end

      def storage_get_names()
        @storage.get_names
      end
      def storage_capacity_kb(key)
        @storage.get_capacity_kb(key)
      end
      def storage_usage_kb(key)
        @storage.get_usage_kb(key)
      end
      def storage_usage_percent(key)
        @storage.get_usage_percent(key)
      end
      def storage_is_sync()
        @storage.is_sync
      end
      def storage_join(key, device)
        @storage.join(key, device)
      end

      def power_battery_percent()
        @power.get_battery_percent()
      end
      def power_is_ac_plugin()
        @power.is_ac_plugin()
      end
    end
  end
end