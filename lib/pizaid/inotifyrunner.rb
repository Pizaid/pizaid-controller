require 'rb-inotify'
require_relative "inotifydev.rb"
require_relative "inotifysync.rb"

module Pizaid
  module Controller
    class InotifyRunner
      def initialize
        @main = INotify::Notifier.new
        @inotifyDev = InotifyDev.new(@main)
        @inotifySync = InotifySync.new(@main)
      end
      def run
        @main.run
      end
      def 
        @main.quit
      end
      attr_reader :inotifyDev
    end
  end
end
