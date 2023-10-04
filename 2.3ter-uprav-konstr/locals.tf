locals {
  ssh-keys = sensitive("ubuntu:${file("~/.ssh/id_rsa.pub")}")
}
