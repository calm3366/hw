terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

locals {
  spisok = {
    "zone1" = {
      zone = var.cl_zone,
      subnet_id = var.subnet_id,
    }
    "zone2" = {
      zone = var.cl_zone2,
      subnet_id = var.subnet_id2,
    }
    "zone3" = {
      zone = var.cl_zone3,
      subnet_id = var.subnet_id3,
    }
  }
}

resource "yandex_mdb_mysql_cluster" "clust_mysql" {
  
  name                = var.cl_name
  environment         = var.env
  network_id          = var.network_id
  version             = "8.0"

  resources {
    resource_preset_id = "s2.micro"
    disk_type_id       = "network-ssd"
    disk_size          = 20
  }

  dynamic "host" {
    for_each = var.HA_clust == true ? local.spisok : local.spisok[0]

    content {
    zone             = host.value.zone
    subnet_id        = host.value.subnet_id
    }
    
  }
}

resource "yandex_mdb_mysql_database" "mysql_cl_db" {
  cluster_id = yandex_mdb_mysql_cluster.clust_mysql.id
  name       = var.name_DB
}


resource "yandex_mdb_mysql_user" "mysql_user" {
  cluster_id = yandex_mdb_mysql_cluster.clust_mysql.id
  name       = var.user_name
  password   = var.user_pass
  permission {
    database_name = var.name_DB
  }
}