require "pizaid/controller/version"
require "dbus"
require "socket"

module Pizaid
  module Controller
    class << self
      def run
        server = Server.new
        server.run
      end
    end

    class Server
      def initialize
        @dbus = DBusRunner.new
      end
      def run
        th_dbus = Thread.new { @dbus.run }
        th_dbus.run
        puts "=== Pizaid Controller ==="
        puts "Start running!"
        shell
        puts "Finalizing..."
        @dbus.quit
        th_dbus.join
      end
      def shell
        while true
          print "> "
          line = gets
          cmd, args = line.split(" ",2)
          case cmd
          when "quit", "q", "exit"
            break
          when "echo"
            print args
          else
            puts "Unknown command"
          end
        end        
      end
    end
    class DBusRunner
      def initialize
        bus     = DBus.session_bus
        service = bus.request_service("com.pizaid.Controller")
        network     = DBusNetwork.new("/com/pizaid/controller/Network")
        service.export(network)

        @main = DBus::Main.new
        @main << bus
      end
      def run
        @main.run
      end
      def quit
        @main.quit
      end
    end
    class DBusNetwork < DBus::Object
      dbus_interface "com.pizaid.network.Properties" do
        dbus_method :Get_ipv4, "out str:s" do
          Socket.getifaddrs.select {|x|
            x.name == "eth0" and x.addr.ipv4?
          }.first.addr.ip_address
        end
        dbus_method :Get_ipv6, "out str:s" do
          Socket.getifaddrs.select {|x|
            x.name == "eth0" and x.addr.ipv6?
          }.first.addr.ip_address
        end
      end
    end
  end
end
