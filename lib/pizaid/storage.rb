module Pizaid
  module Controller
    class Storage
      def initialize
        storage = Struct::new('Storage', :name, :option, :devs)
        @storages = [ storage.new(name: "main", option: "", devs: []),
                      storage.new(name: "sync", option: "-S", devs: []),
                      storage.new(name: "unused", option: "-U", devs: []) ]
        @script_dir = File.expand_path(File.dirname(__FILE__)) + "/scripts"
      end
      def get_names()
        names = @storages.collect { |storage| storage.name }
        puts("get_names: #{names}")
        return names
      end
      def get_capacity_kb(name)
        capacity = 0
        target = @storage.find{ |storage| storage.name == name }
        if target != nil
          capacity = `#{@script_dir}/pizaid-volume #{target.option} --size`.to_i
        end
        puts("get_capacity_kb: #{name}, #{capacity}")
        return capacity
      end
      def get_usage_kb(name)
        used = 0
        target = @storage.find{ |storage| storage.name == name }
        if target != nil
          used = `#{@script_dir}/pizaid-volume #{target.option} --use`.to_i
        end
        puts("Get_used: #{name}, #{used}")
        return used
      end
      def get_usage_percent(name)
        percent = 0
        target = @storage.find{ |storage| storage.name == name }
        if target != nil
          percent = `#{@script_dir}/pizaid-volume #{target.option} --use -p`.to_i
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
        target = @storage.find{ |storage| storage.name == name }
        if target != nil
          rc = system("#{@script_dir}/pizaid-disk #{target.option} #{device}")
        end
        return rc
      end
    end
  end
end
