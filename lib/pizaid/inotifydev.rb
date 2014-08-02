require 'rb-inotify'

module Pizaid
  module Controller
    class InotifyDev < INotify::Watcher
      def initialize(notifyer)
        block = Proc.new{ |event| callbackfunc(event) }
        super(notifyer, "/dev", :create, &block)
      end

      def callbackfunc(event)
        if /^sd[a-z]$/ =~ event.name
          puts event.name
        end
      end
    end
  end
end
