namespace py Pizaid
namespace rb Pizaid

service ControllerService {
     string network_get_ipv4(),
     string network_get_ipv6(),
     
     list<string> storage_names(),
     i64 storage_capacity_kb(1: string key),
     i64 storage_usage_kb(1: string key),
     byte storage_usage_percent(1: string key),
     bool storage_is_sync(),
     bool storage_join(1: string key, 2: string device),
     list<string> storage_devs(1: string key),
     string storage_dev_id(1: string device),
     string storage_dev_size(1: string device),
     byte storage_dev_port(1: string device),

     byte power_battery_percent(),
     bool power_is_ac_plugin()
}
