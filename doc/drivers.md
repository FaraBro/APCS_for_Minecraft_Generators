**gen** -- генераторы (driver_type). Table
- Название типа генераторов (driver_name). Table
	- [init](#init)
	- get_data -- получает данные с генератора и записывает их в `_G.tags.gen[driver_name].data[element]`. Func. Аргументы: element (Number; index)
	- start -- запускает генератор. Func. Аргументы: element (Number; index)
	- stop -- останавливает генератор. Func. Аргументы: element (Number; index)
	- set_throttle -- устанавливает мощность генератора. Func. Аргументы: element (Number; index), throttle (Number; в процентах)

**FS** -- Fluid Storages (driver_type). Table
- Название типа FS (driver_name). Table
	- [init](#init)
	- get_data -- получает данные с FS и записывает их в `_G.tags.FS[driver_name].data[element]`. Func. Аргументы: element (Number; index)

**ES** -- Enegry Storages (driver_type). Table
- Название типа ES (driver_name). Table
	- [init](#init)
	- get_data -- получает данные с ES и записывает их в `_G.tags.ES[driver_name].data[element]`. Func. Аргументы: element (Number; index)

## drivers_tools
drivers_tools является стандартными утилитами драйверов  
В ваших драйверах мы рекомендуем использовать их, так как они помогают обеспечить совместимость при добавлении новых ext, а также уменьшают размер самого файла драйвера  

## init
init -- необязательный элемент любого драйвера.  
Должен находится в корне драйвера (`_G.drivers[driver_type][driver_name].init` или `_G.drivers[driver_name].init`)  
Мы подрузамеваем, что в init вы будете назначать [elements и их ext](/doc/tags.md), напомню что вы можете использовать [drivers_tools](#drivers_tools)  
Любая ошибка в init является критической и приведёт к BSoD (даже если в настройках выстановлено "перезагрузка при ошибке").  
