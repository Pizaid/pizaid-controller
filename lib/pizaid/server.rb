require 'dbus'

module Pizaid
  module Controller
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
  end
end
