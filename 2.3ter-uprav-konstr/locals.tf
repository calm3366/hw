locals {
  file_ssh = file("~/.ssh/id_rsa.pub")
  ssh-keys = sensitive("ubuntu:${local.file_ssh}")

  #parameters = ["name", "id", "fqdn"]
  #spisok_VM = [for k,v in yandex_compute_instance.webVM: "name = ${v.name} id = ${v.id}  fqdn = ${v.fqdn}.fqdn}"]
  #spisok_VM = { for k, v in yandex_compute_instance.webVM : "name = ${v.name} \n  id = ${v.id} \n fqdn = ${v.fqdn} " =>k }

  # spisok_VM = <<EOT
  # %{~ for k, v in yandex_compute_instance.webVM ~}
  # name = ${v.name} 
  # id = ${v.id} 
  # fqdn = ${v.fqdn} 


  # %{~ endfor ~}
  # EOT

  spisok_webVM = [
    for k, v in yandex_compute_instance.webVM :
    zipmap(
      ["1. name", "2. id", "3. fqdn"],
      [
        v.name,
        v.id,
        v.fqdn
      ]
    )
  ]


  spisok_dbVM = [
    for k, v in yandex_compute_instance.db_VM :
    zipmap(
      ["1. name", "2. id", "3. fqdn"],
      [
        v.name,
        v.id,
        v.fqdn
      ]
    )
  ]

  spisok_stVM = zipmap(
    ["1. name", "2. id", "3. fqdn"],
    [
      yandex_compute_instance.storageVM.name,
      yandex_compute_instance.storageVM.id,
      yandex_compute_instance.storageVM.fqdn
    ]
  )



  #spisok_VM02 = [for k, v in yandex_compute_instance.db_VM : "name = ${v.name} \n id = ${v.id} \n fqdn = ${v.fqdn}"]
  #spisok_VM03 = "name = ${yandex_compute_instance.storageVM.name} \n id = ${yandex_compute_instance.storageVM.id} \n fqdn = ${yandex_compute_instance.storageVM.fqdn}"


  # name = yandex_compute_instance.webVM[*].name
  # id =  yandex_compute_instance.webVM[*].id
  # fqdn = yandex_compute_instance.webVM[*].fqdn

  #  name = yandex_compute_instance.storageVM.name
}
