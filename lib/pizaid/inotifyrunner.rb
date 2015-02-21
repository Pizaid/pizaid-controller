require 'rb-inotify'
require_relative "inotifydev.rb"

module Pizaid
  module Controller
    class InotifyRunner
      def initialize
        @main = INotify::Notifier.new
        @inotifyDev = InotifyDev.new(@main)
      end
      def run
        @main.run
      end
      def 
        @main.quit
      end
      attr_reader :inotifyDev
      attr_reader :inotifySync
    end
  end
end
