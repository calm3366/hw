locals {
  file_ssh = file("~/.ssh/id_rsa.pub")
  ssh-keys = sensitive("ubuntu:${local.file_ssh}")

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

  spisok_stVM = [zipmap(
    ["1. name", "2. id", "3. fqdn"],
    [
      yandex_compute_instance.storageVM.name,
      yandex_compute_instance.storageVM.id,
      yandex_compute_instance.storageVM.fqdn
    ]
  )]

}


