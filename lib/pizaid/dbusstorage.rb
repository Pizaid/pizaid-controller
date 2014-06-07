require 'dbus'

module Pizaid
  module Controller
    class DBusStorage < DBus::Object
      def initialize objname
        super objname
        @names = ["main", "sync"]
      end
      dbus_interface "com.pizaid.storage.Properties" do
        dbus_method :Get_names, "out names:as" do
          puts("Get_names: #{@names}")
          return [@names]
        end
        dbus_method :Get_capacity, "in name:s, out kb:i" do |name|
          puts("Get_total: #{name}")
          capacity = 0
          case name
          when @names[0]
            capacity = 1024*1024
          when @names[1]
            capacity = 512*1024
          end
          return capacity
        end
        dbus_method :Get_used, "in name:s, out kb:i" do |name|
          puts("Get_used: #{name}")
          used = 0
          case name
          when @names[0]
            used = 512*1024
          when @names[1]
            used = 256*1024
          end
          return used
        end
        dbus_method :Get_usage, "in name:s, out kb:i" do |name|
          puts("Get_usage: #{name}")
          return 50
        end
      end
    end
  end
end
