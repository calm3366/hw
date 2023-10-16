terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  
  required_version = ">=0.13"

#   backend "s3" {
#     endpoint = "storage.yandexcloud.net"
#     bucket   = "tfstate-test2"
#     key      = "terraform.tfstate"
#     region   = "ru-central1"
#     #encrypt = true #Шифрование state сервером Terraform
#     skip_region_validation      = true
#     skip_credentials_validation = true
#   }

  backend "s3" {
    endpoint = "storage.yandexcloud.net"
    bucket   = "tfstate-test2"
    key      = "terraform.tfstate"
    region   = "ru-central1"
    dynamodb_endpoint = "https://docapi.serverless.yandexcloud.net/ru-central1/b1gjq55q8f7ivhbrrcuu/etnngn3ti5ukjpk3voch"
    dynamodb_table = "tfstate-lock" #Таблица блокировок
    #encrypt = true #Шифрование state сервером Terraform
    skip_region_validation      = true
    skip_credentials_validation = true
  }
}

provider "yandex" {
  token     = var.token
  cloud_id  = var.cloud_id
  folder_id = var.folder_id
  zone      = var.default_zone
}