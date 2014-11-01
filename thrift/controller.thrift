namespace py Pizaid
namespace rb Pizaid

service ControllerService {
     string network_ipv4(),
     string network_ipv6(),
     
     list<string> storage_storage_group_list(),
     i64 storage_capacity_kb(1: string key),
     i64 storage_usage_kb(1: string key),
     byte storage_usage_percent(1: string key),
     bool storage_is_sync(),
     bool storage_join(1: string key, 2: string disk),
     list<string> storage_disk_list(1: string key),
     string storage_disk_id(1: string disk),
     string storage_disk_size(1: string disk),
     byte storage_disk_port(1: string disk),

     byte power_battery_percent(),
     bool power_is_ac_plugin()
}
