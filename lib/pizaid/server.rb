# require_relative 'thrifthandler.rb'
require_relative 'thriftrunner'
require_relative "inotifyrunner.rb"

module Pizaid
  module Controller
    class Server
      def initialize
        @thrift = ThriftRunner.new
        @inotify = InotifyRunner.new
      end
      def run
        th_thrift = Thread.new { @thrift.run }
        th_thrift.run
        th_inotify = Thread.new{ @inotify.run }
        th_inotify.run
        puts "=== Pizaid Controller ==="
        puts "Start running!"
        shell
        puts "Finalizing..."
        @inotify.quit
        th_thrift.kill
        th_inotfry.join
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
