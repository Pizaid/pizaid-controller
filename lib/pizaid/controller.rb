require "pizaid/controller/version"
require_relative "server.rb"

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
