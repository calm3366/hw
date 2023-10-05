resource "local_file" "hosts_cfg" {
  content = templatefile("${path.module}/hosts.tftpl", {
    webservers = [for num in yandex_compute_instance.webVM : num]
    databases  = [for k, v in yandex_compute_instance.db_VM : v]
    storages   = tolist([yandex_compute_instance.storageVM])
  })

  filename = "${abspath(path.module)}/hosts.cfg"
}


resource "null_resource" "web_hosts_provision" {
  #Ждем создания инстанса
  depends_on = [yandex_compute_instance.webVM]

  #Добавление ПРИВАТНОГО ssh ключа в ssh-agent
  provisioner "local-exec" {
    #command = "echo ${local.file_ssh} | ssh-add -"
    #command = "ssh-add ${local.file_ssh}"
    command = "cat ~/.ssh/id_rsa | ssh-add -"
  }

  #Костыль!!! Даем ВМ 60 сек на первый запуск. Лучше выполнить это через wait_for port 22 на стороне ansible
  # В случае использования cloud-init может потребоваться еще больше времени
  provisioner "local-exec" {
    command = "sleep 60"
  }

  #Запуск ansible-playbook
  provisioner "local-exec" {
    command     = "export ANSIBLE_HOST_KEY_CHECKING=False; ansible-playbook -i ${abspath(path.module)}/hosts.cfg ${abspath(path.module)}/test.yml"
    on_failure  = continue #Продолжить выполнение terraform pipeline в случае ошибок
    environment = { ANSIBLE_HOST_KEY_CHECKING = "False" }
    #срабатывание триггера при изменении переменных
  }
  triggers = {
    always_run        = "${timestamp()}"                         #всегда т.к. дата и время постоянно изменяются
    playbook_src_hash = file("${abspath(path.module)}/test.yml") # при изменении содержимого playbook файла
    ssh_public_key    = local.file_ssh                           # при изменении переменной
  }

}
