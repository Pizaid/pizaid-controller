require 'dbus'

module Pizaid
  module Controller
    class DBusPower < DBus::Object
      dbus_interface "com.pizaid.power.Properties" do
        dbus_method :Get_battery_parcentage, "out parcent:i" do |name|
          parcent = 50
          puts("Get_battery_parcentage: #{parcent}")
          return parcent
        end
        dbus_method :Is_ac_plugin, "out plugged:b" do
          plugged = true
          puts("Is_ac_plugin: #{plugged}")
          return plugged
        end
      end
    end
  end
end
