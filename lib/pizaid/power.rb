module Pizaid
  module Controller
    class Power
      def get_battery_percent()
        percent = 50
        puts("get_battery_percent: #{percent}")
        return percent
      end
      def is_ac_plugin()
        plugged = true
        puts("Is_ac_plugin: #{plugged}")
        return plugged
      end
    end
  end
end
