# -*- coding: utf-8 -*-
require 'dbus'

module Pizaid
  module Controller
    class DBusStorage < DBus::Object
      def initialize objname
        super objname
        @names = ["main", "sync"]
      end
      dbus_interface "com.pizaid.storage.Properties" do
        # ディスク名の一覧
        dbus_method :Get_names, "out names:as" do
          puts("Get_names: #{@names}")
          return [@names]
        end
        # ディスクの容量[kB]
        dbus_method :Get_capacity_kb, "in name:s, out kb:i" do |name|
          capacity = 0
          case name
          when @names[0]
            capacity = 1024*1024
          when @names[1]
            capacity = 512*1024
          end
          puts("Get_total: #{name}, #{capacity}")
          return capacity
        end
        # ディスクの使用量[kB]
        dbus_method :Get_usage_kb, "in name:s, out kb:i" do |name|
          used = 0
          case name
          when @names[0]
            used = 512*1024
          when @names[1]
            used = 256*1024
          end
          puts("Get_used: #{name}, #{used}")
          return used
        end
        # ディスクの使用量[%]
        dbus_method :Get_usage_percent, "in name:s, out percent:i" do |name|
          percent = 50
          puts("Get_usage: #{name}, #{percent}")
          return percent
        end
        # masterとslaveの同期がとれたか？
        dbus_method :Is_sync, "out synced:b" do
          synced = true
          puts("Is_sync: #{synced}")
          return synced
        end
      end
    end
  end
end
