resource "yandex_vpc_network" "develop" {
  name = var.vpc_name
}
resource "yandex_vpc_subnet" "develop" {
  name           = var.vpc_name
  zone           = var.default_zone
  network_id     = yandex_vpc_network.develop.id
  v4_cidr_blocks = var.default_cidr
}


data "yandex_compute_image" "ubuntu" {
  family = var.vm_web_family
}


resource "yandex_compute_instance" "platform" {
  name = local.vm_web_platform_name
  platform_id = var.vm_web_platform_id
  resources {
    cores         = var.vms_resources.cores.web 
    memory        = var.vms_resources.memory.web
    core_fraction = var.vms_resources.core_fraction.web
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    #https://cloud.yandex.ru/docs/compute/concepts/preemptible-vm
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = var.serial-port-enable
    ssh-keys           = local.ssh-keys
  }

}



resource "yandex_compute_instance" "netology-develop-platform-db" {
  name        = var.vm_db_platform_name
  platform_id = var.vm_db_platform_id
  resources {
    cores         = var.vms_resources.cores.db
    memory        = var.vms_resources.memory.db
    core_fraction = var.vms_resources.core_fraction.db
  }
  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu.image_id
    }
  }
  scheduling_policy {
    #https://cloud.yandex.ru/docs/compute/concepts/preemptible-vm
    preemptible = true
  }
  network_interface {
    subnet_id = yandex_vpc_subnet.develop.id
    nat       = true
  }

  metadata = {
    serial-port-enable = 1
    ssh-keys           = "${var.ssh_login}:${var.vms_ssh_root_key}"
  }

}