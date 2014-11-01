require 'socket'

module Pizaid
  module Controller
    class Network
      def ipv4()
          Socket.getifaddrs.select {|x|
            x.name == "eth0" and x.addr.ipv4?
          }.first.addr.ip_address
      end
      def ipv6()
          Socket.getifaddrs.select {|x|
            x.name == "eth0" and x.addr.ipv6?
          }.first.addr.ip_address
      end
    end
  end
end
