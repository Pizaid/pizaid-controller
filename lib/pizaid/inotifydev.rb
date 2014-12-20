require 'rb-inotify'

module Pizaid
  module Controller
    class InotifyDev < INotify::Watcher
      def initialize(notifyer)
        @storageUpdateDiskMethod = nil
        block = Proc.new{ |event| callBackMethod(event) }
        super(notifyer, '/dev', :create, &block)
      end

      def callBackMethod(event)
        if /^sd[a-z]$/ =~ event.name
          puts event.name
          if @storageUpdateDiskMethod != nil
            @storageUpdateDiskMethod.call
          end
        end
      end

      attr_writer :storageUpdateDiskMethod
    end
  end
end
