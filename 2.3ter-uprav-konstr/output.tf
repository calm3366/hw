output "spisok_VM" {
 value = local.spisok_VM
 #value = {for num in yandex_compute_instance.webVM: num.name => num }
}