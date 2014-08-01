# -*- coding: utf-8 -*-
require 'dbus'

module Pizaid
  module Controller
    class DBusPower < DBus::Object
      dbus_interface "com.pizaid.power.Properties" do
        # バッテリーの残量 [%]
        dbus_method :Get_battery_percent, "out percent:i" do
          percent = 50
          puts("Get_battery_percentage: #{percent}")
          return percent
        end
        # ACアダプタが刺さっているか? (true = 刺さってる)
        dbus_method :Is_ac_plugin, "out plugged:b" do
          plugged = true
          puts("Is_ac_plugin: #{plugged}")
          return plugged
        end
      end
    end
  end
end
