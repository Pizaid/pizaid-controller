require 'rb-inotify'

module Pizaid
  module Controller
    class InotifyDev
      def initialize(notifyer)
        @watcher = nil
        @storageUpdateDiskMethod = nil
        block = Proc.new{ |event| callBackMethod(event) }
        @watcher = notifyer.watch('/dev', :create, &block)
      end

      def callBackMethod(event)
        if /^sd[a-z]$/ =~ event.name
          @storageUpdateDiskMethod.call if @storageUpdateDiskMethod
        end
      end

      attr_writer :storageUpdateDiskMethod
    end
  end
end
