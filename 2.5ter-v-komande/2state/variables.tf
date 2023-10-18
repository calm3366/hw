###cloud vars
variable "token" {
  type        = string
  description = "OAuth-token; https://cloud.yandex.ru/docs/iam/concepts/authorization/oauth-token"
}

variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}

variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}


###common vars



variable "username" {
  type    = string
  default = "ubuntu"
}


variable "file_ssh_public_key" {
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "ipv4" {
  type        = string
  default     = "192.168.0.1"
  description = "ip-адрес"
  validation {
    #  condition     = can(cidrnetmask("${var.ipv4}/24")) #существует ли любой адрес
    condition = can(regex("192.168.0\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", var.ipv4))

    error_message = "Неверный IP адрес"
  }
}

variable "spisok-ipv4" {
  type        = list(string)
  description = "список ip-адресов"
  default     = ["192.168.0.1", "1.1.1.1", "127.0.0.1"]
  validation {
    condition = alltrue([
      for k in var.spisok-ipv4 : can(regex("^(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)\\.(25[0-5]|2[0-4][0-9]|[01]?[0-9][0-9]?)$", k))
    ])
    error_message = "Неверный список IP адресов"
  }
}

variable "in_the_end_there_can_be_only_one" {
  description = "Who is better Connor or Duncan?"
  type = object({
    Dunkan = optional(bool)
    Connor = optional(bool)
  })
  default = {
    Dunkan = true
    Connor = false
  }
  validation {
    error_message = "There can be only one MacLeod"
    condition     = var.in_the_end_there_can_be_only_one.Dunkan == var.in_the_end_there_can_be_only_one.Connor ? false : true
  }
}

variable "string_value" {
  description = "любая строка без символов верхнего регистра"
  default     = "abc"
  type        = string
  validation {
    error_message = "Должна быть не нулевая строка без символов верхнего регистра"
    condition     = can(regex("^[^A-Z^А-Я]{1,}$", var.string_value))
  }
}

