# -*- coding: utf-8 -*-
require 'dbus'
require 'socket'

module Pizaid
  module Controller
    class DBusNetwork < DBus::Object
      dbus_interface "com.pizaid.network.Properties" do
        # IPv4アドレス
        dbus_method :Get_ipv4, "out str:s" do
          Socket.getifaddrs.select {|x|
            x.name == "eth0" and x.addr.ipv4?
          }.first.addr.ip_address
        end
        # IPv6アドレス
        dbus_method :Get_ipv6, "out str:s" do
          Socket.getifaddrs.select {|x|
            x.name == "eth0" and x.addr.ipv6?
          }.first.addr.ip_address
        end
        dbus_method :Update_ipv4, "in ipstr:s, out result:b" do |ipstr|
          return false if not validate_ipv4(ipstr)
          rc = set_ipv4(ipstr)
          self.StatusUpdated()
          return rc
        end
        dbus_signal :StatusUpdated
      end
      def set_ipv4(str)
        puts str
        return true
      end
      def validate_ipv4(str)
        return false if str.class != String
        nums = str.scan(/^(\d+)\.(\d+)\.(\d+)\.(\d+)$/)
        return false unless nums.length == 1
        return false unless nums[0].length == 4
        for n in nums[0] do
          return false unless n.to_i >= 0 && n.to_i <= 255
        end
        return true
      end
    end
  end
end
