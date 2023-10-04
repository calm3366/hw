resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = [for num in yandex_compute_instance.webVM : num]
    databases  = [for k, v in yandex_compute_instance.db_VM : v]
    storages   = tolist([yandex_compute_instance.storageVM])
  })

  filename = "${abspath(path.module)}/hosts.cfg"
}