module "test-vm" {
  source       = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
  subnet_zones = module.vpc_prod.vpc_zone

  env_name   = module.vpc_prod.name_vpc_net
  network_id = module.vpc_prod.id_vpc_net
  subnet_ids = module.vpc_prod.sub_id_vpc_net

  instance_name  = "web"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  metadata = {
    user-data          = data.template_file.cloudinit.rendered 
    serial-port-enable = 1
  }

}

data "template_file" "cloudinit" {
  template = file("./cloud-init.yml")
  vars = {
    username       = var.username
    ssh_public_key = file(var.file_ssh_public_key)
  }
}



module "vpc_prod" {
  source   = "./vpc"
  env_name = "production"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
    { zone = "ru-central1-b", cidr = "10.0.2.0/24" },
    { zone = "ru-central1-c", cidr = "10.0.3.0/24" },
  ]
}

module "vpc_dev" {
  source   = "./vpc"
  env_name = "develop"
  subnets = [
    { zone = "ru-central1-a", cidr = "10.0.1.0/24" },
  ]
}


module "clust_mysql" {
  source      = "./bd_clust"
  cl_name     = "my_clust_bd"
  network_id  = module.vpc_prod.id_vpc_net
  HA_clust = false
  cl_zone     = module.vpc_prod.vpc_zone[0]
  subnet_id   = module.vpc_prod.sub_id_vpc_net[0]
  cl_zone2     = module.vpc_prod.vpc_zone[1]
  subnet_id2   = module.vpc_prod.sub_id_vpc_net[1]
  cl_zone3     = module.vpc_prod.vpc_zone[2]
  subnet_id3   = module.vpc_prod.sub_id_vpc_net[2]
  env = "PRESTABLE"
  name_DB = "test"
  user_name = "app"
  user_pass = "mysql-test"
}