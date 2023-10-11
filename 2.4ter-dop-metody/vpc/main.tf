terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}


resource "yandex_vpc_network" "my_develop" {
  name = var.env_name
}
resource "yandex_vpc_subnet" "my_develop" {
  count = length(var.subnets)
  
  name           = "subnet_${var.env_name}0${count.index+1}"
  zone           = var.subnets[count.index].zone
  network_id     = yandex_vpc_network.my_develop.id
  v4_cidr_blocks = [var.subnets[count.index].cidr]
  
}

output "name_vpc_net" {
  value = yandex_vpc_network.my_develop.name
}

output "id_vpc_net" {
  value = yandex_vpc_network.my_develop.id
}

output "sub_id_vpc_net" {
  value = yandex_vpc_subnet.my_develop[*].id
}

output "vpc_zone" {
  value = yandex_vpc_subnet.my_develop[*].zone
}