# output "spisok__VM" {
#   value = "%{for k in yandex_compute_instance.webVM}name = ${k.name}\nid = ${k.id}\nfqdn = ${k.fqdn}\n\n%{endfor}%{for k2 in yandex_compute_instance.db_VM}name = ${k2.name}\nid = ${k2.id}\nfqdn = ${k2.fqdn}\n\n%{endfor}name = ${yandex_compute_instance.storageVM.name}\nid = ${yandex_compute_instance.storageVM.id}\nfqdn = ${yandex_compute_instance.storageVM.fqdn}"
# }


output "spisok_VM" {
  value = [local.spisok_webVM, local.spisok_dbVM, local.spisok_stVM]
}
