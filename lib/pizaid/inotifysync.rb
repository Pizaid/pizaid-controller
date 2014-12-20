require 'rb-inotify'

module Pizaid
  module Controller
    class InotifySync < INotify::Watcher
      def initialize(notifyer)
        block = Proc.new{ |event| callBackMethod(event)}
        watchEvents = [:attrib, :close_write, :create, :delete:, :move_from, :move_to]
        super(notifyer, '/mnt/Pizaid', *watchEvents, &block)
      end

      def callBackMethod(event)
        puts event.name
        puts event.flags
      end
    end
  end
end
