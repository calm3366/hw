resource "yandex_compute_instance" "db_VM" {
  for_each = { for num in var.res_for_VM : index(var.res_for_VM, num) => num }
  name     = each.value.vm_name

  resources {
    cores         = each.value.cpu
    memory        = each.value.ram
    core_fraction = each.value.core_fraction
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
      size     = each.value.disk
    }
  }

  network_interface {
    subnet_id          = yandex_vpc_subnet.develop.id
    nat                = true
    security_group_ids = [yandex_vpc_security_group.example.id]
  }


  scheduling_policy {
    preemptible = true
  }

  metadata = {
    ssh-keys = local.ssh-keys
  }
  allow_stopping_for_update = true
}