require 'socket'

module Pizaid
  module Controller
    class Network
      def ipv4()
        ip_address = nil
        begin
          ip_address = Socket.getifaddrs.select {|x|
            x.name == "eth0" and x.addr.ipv4?
          }.first.addr.ip_address
        rescue
          ip_address = "NoIPV4"
        end
      end
      def ipv6()
        ip_address = nil
        puts "calledipv6"
        begin
          ip_address = Socket.getifaddrs.select {|x|
            x.name == "eth0" and x.addr.ipv6?
          }.first.addr.ip_address
        rescue
          ip_address = "NoIPV6"
        end
      end
    end
  end
end
