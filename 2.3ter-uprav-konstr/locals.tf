locals {
  file_ssh = file("~/.ssh/id_rsa.pub")
  ssh-keys = sensitive("ubuntu:${local.file_ssh}")

  parameters = ["name", "id", "fqdn"]
  #spisok_VM = [for k,v in yandex_compute_instance.webVM: "name = ${v.name} id = ${v.id}  fqdn = ${v}.fqdn}"]
  spisok_VM = { for k, v in yandex_compute_instance.webVM : "name = ${v.name}" => "id = ${v.id} \n fqdn = ${v.fqdn} "... }


  #spisok_VM = [for k,v in yandex_compute_instance.webVM: "name = ${v.var.parameters} " ]

  spisok_VM02 = [for k, v in yandex_compute_instance.db_VM : "name = ${v.name} \n id = ${v.id} \n fqdn = ${v.fqdn}"]
  spisok_VM03 = "name = ${yandex_compute_instance.storageVM.name} \n id = ${yandex_compute_instance.storageVM.id} \n fqdn = ${yandex_compute_instance.storageVM.fqdn}"
  # name = yandex_compute_instance.webVM[*].name
  # id =  yandex_compute_instance.webVM[*].id
  # fqdn = yandex_compute_instance.webVM[*].fqdn

  #  name = yandex_compute_instance.storageVM.name
}
