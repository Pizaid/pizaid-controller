# require_relative 'thrifthandler.rb'
require_relative 'thriftrunner'

module Pizaid
  module Controller
    class Server
      def initialize
        @thrift = ThriftRunner.new
      end
      def run
        th_thrift = Thread.new { @thrift.run }
        th_thrift.run
        puts "=== Pizaid Controller ==="
        puts "Start running!"
        shell
        puts "Finalizing..."
        th_thrift.kill
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
