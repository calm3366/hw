output "spisok_VM" {
  value = concat(local.spisok_webVM, local.spisok_dbVM, local.spisok_stVM)
}

