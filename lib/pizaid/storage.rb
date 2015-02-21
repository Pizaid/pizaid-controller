module Pizaid
  module Controller
    class Storage
      def initialize
        storageGroup = Struct::new('StorageGroup', :name, :option, :disks)
        @storageGroups = [ storageGroup.new("main","", []),
                          storageGroup.new("sync", "-S", []),
                          storageGroup.new("unused","-U", []) ]
        @script_dir = File.expand_path(File.dirname(__FILE__)) + "/scripts"
        @startSyncMethod = nil
        updateDisks
      end
      def storageGroupList()
        list = @storageGroups.collect { |storageGroup| storageGroup.name }
        puts("storageGroupList: #{list}")
        return list
      end
      def capacityKB(storageGroupName)
        capacity = 0
        target = @storageGroups.find{ |storageGroup| storageGroup.name == storageGroupName }
        if target != nil
          capacity = `#{@script_dir}/pizaid-volume #{target.option} --size`.to_i
        end
        puts("capacityKB: #{storageGroupName}, #{capacity}")
        return capacity
      end
      def usageKB(storageGroupName)
        used = 0
        target = @storageGroups.find{ |storageGroup| storageGroup.name == storageGroupName }
        if target != nil
          used = `#{@script_dir}/pizaid-volume #{target.option} --use`.to_i
        end
        puts("getUsageKB: #{storageGroupName}, #{used}")
        return used
      end
      def usagePercent(storageGroupName)
        percent = 0
        target = @storageGroups.find{ |storageGroup| storageGroup.name == storageGroupName }
        if target != nil
          percent = `#{@script_dir}/pizaid-volume #{target.option} --use -p`.to_i
        end
        puts("usageParcent: #{storageGroupName}, #{percent}")
        return percent
      end
      def isSync()
        synced = true
        puts("isSync: #{synced}")
        return synced
      end
      def join(storageGroupName, disk)
        rc = false
        target = @storageGroups.find{ |storageGroup| storageGroup.name == storageGroupName }
        if target != nil
          rc = system("#{@script_dir}/pizaid-disk #{target.option} #{disk}")
        end
        updateDisks
        return rc
      end
      def updateDisks()
        @storageGroups.each{ |storageGroup|
          storageGroup.disks = `#{@script_dir}/pizaid-dev #{storageGroup.option}`.split
        }
        unless @storageGroups.find{ |storageGroup| storageGroup.name=="sync"}.disks.empty?
          @startSyncMethod.call if @startSyncMethod
        end
        puts "updateDisk"
      end
      def diskList(storageGroupName)
        list = []
        target = @storageGroups.find{ |storageGroup| storageGroup.name == storageGroupName }
        if target != nil
          list = target.disks
        end
        puts("diskList: #{list}")
        return list
      end
      def diskID(disk)
        id = `udevadm info --name=#{disk} --query=property  | grep 'ID_SERIAL=' | sed 's/ID_SERIAL=//g'`
        puts("diskID: #{id}")
        return id.chomp
      end
      def diskSize(disk)
        size = `fdisk -l #{disk} | grep 'Disk' | grep 'bytes' |  awk '{ print $3$4}' | sed 's/,//g'`
        puts("diskSize: #{size}")
        return size.chomp
      end
      def diskPort(disk)
        port = `udevadm info --name=#{disk} --query=property  | grep 'ID_PATH=' | sed s'/ID_PATH=platform-bcm2708_usb-usb-0:1\.//g' | sed 's/:1\.0-scsi-0:0:0:0//g'`.to_i - 1
        puts("diskPort: #{port}")
        return port
      end

      def setStartSyncMethod(method)
        @startSyncMethod = method
        updateDisks
      end
    end
  end
end
