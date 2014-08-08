module Pizaid
  module Controller
    class Storage
      def initialize
        @names = ["main", "sync"]
        @script_dir = File.expand_path(File.dirname(__FILE__)) + "/scripts"
      end
      def get_names()
        puts("get_names: #{@names}")
        return @names
      end
      def get_capacity_kb(name)
        capacity = 0
        case name
        when @names[0]
          capacity = `#{@script_dir}/pizaid-volume --size`.to_i
        when @names[1]
          capacity = `#{@script_dir}/pizaid-volume -S --size`.to_i
        end
        puts("get_capacity_kb: #{name}, #{capacity}")
        return capacity
      end
      def get_usage_kb(name)
        used = 0
        case name
        when @names[0]
          used = `#{@script_dir}/pizaid-volume --use`.to_i
        when @names[1]
          used = `#{@script_dir}/pizaid-volume -S --use`.to_i
        end
        puts("Get_used: #{name}, #{used}")
        return used
      end
      def get_usage_percent(name)
        percent = 0
        case name
        when @names[0]
          percent = `#{@script_dir}/pizaid-volume --use -p`.to_i
        when @names[1]
          percent = `#{@script_dir}/pizaid-volume -S --use -p`.to_i
        end
        puts("Get_usage: #{name}, #{percent}")
        return percent
      end
      def is_sync()
        synced = true
        puts("is_sync: #{synced}")
        return synced
      end
      def join(name, device)
        rc = false
        case name
        when @names[0]
          rc = system("#{@script_dir}/pizaid-disk #{device}")
        when @names[1]
          rc = system("#{@script_dir}/pizaid-disk -S #{device}")
        end
        return rc
      end
    end
  end
end
