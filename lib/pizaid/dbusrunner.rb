require 'dbus'
require_relative "dbusrunner.rb"
require_relative "dbusnetwork.rb"
require_relative "dbusstorage.rb"
require_relative "dbuspower.rb"

module Pizaid
  module Controller
    class DBusRunner
      def initialize
        bus     = DBus.session_bus
        service = bus.request_service("com.pizaid.Controller")
        network = DBusNetwork.new("/com/pizaid/controller/Network")
        storage = DBusStorage.new("/com/pizaid/controller/Storage")
        power   = DBusPower.new("/com/pizaid/controller/Power")
        service.export(network)
        service.export(storage)
        service.export(power)
        @main = DBus::Main.new
        @main << bus
      end
      def run
        @main.run
      end
      def quit
        @main.quit
      end
    end
  end
end
