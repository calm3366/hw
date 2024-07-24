## Задание 1
##### Ошибка в названии платформы для CPU - выбрал standard-v1
##### preemptible = true (прерываемость ВМ: пригодится для меньшего потребления бюджета YC)
##### core_fraction=5 (максимальная загрузка CPU также подойдет для низконагруженных тестовых ВМ)
![Alt text](<work2/img/Снимок экрана 2023-09-29 в 12.11.31.png>)
![Alt text](<work2/img/Снимок экрана 2023-09-29 в 12.12.49.png>)
## Задание 2
 <pre> name = local.vm_web_platform_name
  platform_id = var.vm_web_platform_id
  family = var.vm_web_family
  name        = var.vm_db_platform_name
  platform_id = var.vm_db_platform_id
  </pre>
[variables.tf](work2/variables.tf) 

[main.tf](work2/main.tf) 

Изменений нет

![Alt text](<work2/img/Снимок экрана 2023-09-29 в 12.50.51.png>)
## Задание 3
[vms_platform.tf](work2/vms_platform.tf) 

[main.tf](work2/main.tf) 

![Alt text](<work2/img/Снимок экрана 2023-09-29 в 13.12.55.png>)
## Задание 4
[outputs.tf](work2/outputs.tf) 

![Alt text](<work2/img/Снимок экрана 2023-09-30 в 16.05.15.png>)
## Задание 5
[locals.tf](work2/locals.tf) 

![Alt text](<work2/img/Снимок экрана 2023-09-30 в 16.24.37.png>)
## Задание 6
[variables.tf](work2/variables.tf) 

[main.tf](work2/main.tf) 

## Задание 7*
```bash 
local.test_list[1] 

length(local.test_list)

local.test_map["admin"]

"${local.test_map["admin"]} is admin for ${local.test_list[2]} server based on  OS ${local.servers.stage.image} with ${local.servers.stage.cpu} cpu, ${local.servers.stage.ram} ram and ${length(local.servers.stage.disks)} virtual disks" 
```
![Alt text](<work2/img/Снимок экрана 2023-09-30 в 18.07.24.png>)

