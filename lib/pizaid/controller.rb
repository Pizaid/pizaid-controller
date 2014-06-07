require "pizaid/controller/version"
require "dbus"
require "socket"

require_relative "server.rb"
require_relative "dbusrunner.rb"
require_relative "dbusnetwork.rb"
require_relative "dbusstorage.rb"
require_relative "dbuspower.rb"

module Pizaid
  module Controller
    class << self
      def run
        server = Server.new
        server.run
      end
    end
  end
end
