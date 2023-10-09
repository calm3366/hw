module "test-vm" {
  source         = "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main"
subnet_zones   = ["ru-central1-a"]

   env_name       = module.vpc.name_vpc_net
   network_id     = module.vpc.id_vpc_net
   subnet_ids     = module.vpc.sub_id_vpc_net
  
  instance_name  = "web"
  instance_count = 1
  image_family   = "ubuntu-2004-lts"
  public_ip      = true

  metadata = {
    user-data          = data.template_file.cloudinit.rendered #Для демонстрации №3
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


module "vpc" {
  source   = "./vpc"
  zone     = "ru-central1-a"
  env_name = "my-network"
  cidr     = ["10.0.10.0/24"]
}