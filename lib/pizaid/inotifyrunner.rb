require 'rb-inotify'
require_relative "inotifydev.rb"

module Pizaid
  module Controller
    class InotifyRunner
      def func2
        puts "hoge2"
      end
      def initialize
        @main = INotify::Notifier.new
        InotifyDev.new(@main)
      end
      def run
        @main.run
      end
      def 
        @main.quit
      end
    end
  end
end
