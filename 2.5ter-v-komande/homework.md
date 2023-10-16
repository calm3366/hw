## Задание 1
```main.tf:33:21: Warning - Module source "git::https://github.com/udjin10/yandex_compute_instance.git?ref=main" uses a default branch as ref (main) (terraform_module_pinned_source)```
уведомление о том, что используется основная ветка гита без привязки к коммиту
```main.tf:51:1: Warning - Missing version constraint for provider "template" in `required_providers` (terraform_required_providers)```
нужно задать версию для **data "template_file"**
```variables.tf:22:1: Warning - variable "default_cidr" is declared but not used (terraform_unused_declarations)```
переменная не используется **default_cidr**
```
Check: CKV_TF_1: "Ensure Terraform module sources use a commit hash"
	FAILED for resource: test-vm
	File: /main.tf:32-48
```
нужно использовать хеш коммита для надежности версий
## Задание 2



[cloud-init.yml](cloud-init.yml) 

![!\[Alt text\](<img/!\[Alt text\](<img/Снимок экрана 2023-10-06 в 18.15.07.png>)>)](<img/Снимок экрана 2023-10-06 в 18.15.07.png>)
