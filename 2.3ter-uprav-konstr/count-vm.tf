data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}

resource "yandex_compute_instance" "webVM" {
  count = 2
  name  = "web-${count.index + 1}"

  resources {
    cores         = var.vm_resources.cores.web
    memory        = var.vm_resources.memory.web
    core_fraction = var.vm_resources.core_fraction.web
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    #nat                = true
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