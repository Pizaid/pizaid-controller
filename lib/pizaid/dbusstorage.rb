# -*- coding: utf-8 -*-
require 'dbus'

module Pizaid
  module Controller
    class DBusStorage < DBus::Object
      def initialize objname
        super objname
        @names = ["main", "sync"]
        @script_dir = File.expand_path(File.dirname(__FILE__)) + "/scripts"
      end
      dbus_interface "com.pizaid.storage.Properties" do
        # ディスク名の一覧
        dbus_method :Get_names, "out names:as" do
          puts("Get_names: #{@names}")
          puts @dir
          return [@names]
        end
        # ディスクの容量[kB]
        dbus_method :Get_capacity_kb, "in name:s, out kb:i" do |name|
          capacity = 0
          case name
          when @names[0]
            capacity = `#{@script_dir}/pizaid-volume --size`.to_i
          when @names[1]
            capacity = `#{@script_dir}/scripts/pizaid-volume -S --size`.to_i
          end
          puts("Get_total: #{name}, #{capacity}")
          return capacity
        end
        # ディスクの使用量[kB]
        dbus_method :Get_usage_kb, "in name:s, out kb:i" do |name|
          used = 0
          case name
          when @names[0]
            used = `#{@script_dir}/pizaid-volume --use`.to_i
          when @names[1]
            used = `#{@script_dir}/pizaid-volume -S --use`.to_i
          end
          puts("Get_used: #{name}, #{used}")
          return used
        end
        # ディスクの使用量[%]
        dbus_method :Get_usage_percent, "in name:s, out percent:i" do |name|
          percent = 0
          case name
          when @names[0]
            percent = `#{@script_dir}/pizaid-volume --use -p`.to_i
          when @names[1]
            percent = `#{@script_dir}/pizaid-volume -S --use -p`.to_i
          end
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
      dbus_interface "com.pizaid.storage.Operations" do
        dbus_method :Join, "in name:s, in device:s" do |name,device|
          case name
          when @names[0]
            `#{@script_dir}/pizaid-disk #{device}`
          when @names[1]
            `#{@script_dir}/pizaid-disk -S #{device}`
          end
        end
      end
    end
  end
end
