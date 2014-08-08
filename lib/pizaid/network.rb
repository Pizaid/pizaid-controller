require 'socket'

module Pizaid
  module Controller
    class Network
      def get_ipv4()
          Socket.getifaddrs.select {|x|
            x.name == "eth0" and x.addr.ipv4?
          }.first.addr.ip_address
      end
      def get_ipv6()
          Socket.getifaddrs.select {|x|
            x.name == "eth0" and x.addr.ipv6?
          }.first.addr.ip_address
      end
      def update_ipv4(newip)
          return false if not validate_ipv4(newip)
          rc = set_ipv4(newip)
          self.StatusUpdated()
          return rc
      end

      private
      def set_ipv4(str)
        puts "set_ipv4: ", str
        return true
      end
      def validate_ipv4(str)
        return false if str.class != String
        nums = str.scan(/^(\d+)\.(\d+)\.(\d+)\.(\d+)$/)
        return false unless nums.length == 1
        return false unless nums[0].length == 4
        for n in nums[0] do
          return false unless n.to_i >= 0 && n.to_i <= 255
        end
        return true
      end
    end
  end
end
