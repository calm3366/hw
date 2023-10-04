locals {
    vm_web_platform_name = "netology-${var.vpc_name}-platform-web"
    ssh-keys = "${var.ssh_login}:${var.vms_ssh_root_key}"
}

