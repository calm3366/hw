terraform {
  required_providers {
    virtualbox = {
      source = "shekeriev/virtualbox"
      version = "0.0.4"
    }
  }
}

provider "virtualbox" {
  delay      = 60
  mintimeout = 5
}

resource "virtualbox_vm" "vm1" {
  name   = "debian"
  image  = "https://github.com/kraksoft/vagrant-box-debian/releases/download/7.8.0/debian-7.8.0-amd64.box"
  cpus      = 2
  memory    = "1024 mib"
  user_data = file("${path.module}/user-data")

  network_adapter {
    type           = "nat"
   # device         = "IntelPro1000MTDesktop"
   #host_interface = "en6: USB 10/100/1000 LAN"
    # On Windows use this instead
    #host_interface = "VirtualBox Host-Only Ethernet Adapter"
  }
}

output "IPAddress" {
  value = element(virtualbox_vm.vm1.*.network_adapter.0.ipv4_address, 1)
}

