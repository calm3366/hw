output "ext_ip_web_ser" {
  value       = "external ip vm_web = ${yandex_compute_instance.platform.network_interface[0].nat_ip_address}"    
  #https://www.devopsschool.com/blog/terraform-output-variable-example/       
}
output "ext_ip_db_ser" {
  value       = "external ip vm_db = ${yandex_compute_instance.netology-develop-platform-db.network_interface[0].nat_ip_address}"           
}