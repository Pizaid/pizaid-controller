$:.push(File.expand_path(File.dirname(__FILE__))+'/gen-rb')
$:.unshift(File.expand_path(File.dirname(__FILE__)))

require 'thrift'
require 'thrifthandler'
require 'controller_service'

module Pizaid
  module Controller
    class ThriftRunner
      def initialize
        handler = ThriftHander.new
        processor = ControllerService::Processor.new(handler)
        transport = Thrift::ServerSocket.new(9090)
        transportFactory = Thrift::BufferedTransportFactory.new
        @server = Thrift::SimpleServer.new(processor, transport, transportFactory)
      end
      def run
        @server.serve()
      end
      def quit
      end
    end
  end
end

