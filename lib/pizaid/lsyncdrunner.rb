module Pizaid
  module Controller
    class LsyncdRunner
      def initialize
        @pid = nil
      end
      def run
        unless @pid
          @pid = Process.spawn 'lsyncd -nodaemon -delay 1 -direct /mnt/Pizaid /mnt/Pizaid-Sync'
          puts "start lsyncd with pid "+@pid.to_s
        end
      end
      def quit
        unless @pid
          Process.kill("TERM", @pid)
          @pid = nil
        end
      end
    end
  end
end
