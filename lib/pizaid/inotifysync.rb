require 'rb-inotify'

module Pizaid
  module Controller
    class InotifySync
      def initialize(notifyer)
        @watcher = nil
      end

      def callBackMethod(event)
        options = "-a"
        options += "c" if event.flags.include?(:attrib)
        src = event.absolute_name
        dest = File.dirname(src).gsub(/^\/mnt\/Pizaid/, '/mnt/Pizaid-Sync')
        command = "rsync options \"#{src}\" \"#{dest}\""
        puts command
      end

      def startSync
        return if @watcher
        block = Proc.new{ |event| callBackMethod(event)}
        watchEvents = [:recursive, :attrib, :close_write, :create, :delete, :moved_from, :moved_to]
        @watcher = notifyer.watch('/mnt/Pizaid', *watchEvents, &block)
      end
    end
  end
end
