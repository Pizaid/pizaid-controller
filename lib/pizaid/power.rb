module Pizaid
  module Controller
    class Power
      def batteryPercent()
        percent = 50
        puts("batteryPercent: #{percent}")
        return percent
      end
      def isACPlugin()
        plugged = true
        puts("isACPlugin: #{plugged}")
        return plugged
      end
    end
  end
end
