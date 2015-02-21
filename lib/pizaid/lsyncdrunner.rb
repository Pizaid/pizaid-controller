module Pizaid
  module Controller
    class LsyncdRunner
      def initialize
        @pid = nil
      end
      def run
        if !@pid
          @pid = Process.spawn 'lsyncd -nodaemon -delay 1 -direct /mnt/Pizaid /mnt/Pizaid-sync'
        end
      end
      def quit
        if !@pid
          Process.kill("TERM", @pid)
          @pid = nil
        end
      end
    end
  end
end
