resource "yandex_compute_disk" "new-disk" {
  count = 3
  name  = "empty-disk-${count.index + 1}"
  type  = "network-hdd"
  zone  = var.default_zone
  size  = 10
}

resource "yandex_compute_instance" "storageVM" {
  name = "storage"

  resources {
    cores         = var.vm_resources.cores.storage
    memory        = var.vm_resources.memory.storage
    core_fraction = var.vm_resources.core_fraction.storage
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  dynamic "secondary_disk" {
    for_each = { for num in yandex_compute_disk.new-disk[*] : num.name => num }
    content {
      disk_id = secondary_disk.value.id
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
}