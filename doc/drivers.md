**gen** -- генераторы. Table
- Название типа генераторов. Table
	- get_elements -- получает все proxy генераторов своего типа и записывает их в `_G.tags.[имя типа генераторов].elements`. Func
	- get_data_individual -- получает данные с генератора и записывает их в `_G.tags.[имя типа генераторов].data[element]`. Func. Аргументы: element (Number; index)
	- get_data -- получает данные с элементов генераторов и записывает их в `_G.tags.[имя типа генераторов].data`. Func
	- start_individual -- запускает 1 генератор. Func. Аргументы: element (Number; index)
	- start -- запускает все генераторы. Func
	- stop_individual -- останавливает 1 генератор. Func. Аргументы: element (Number; index)
	- stop -- останавливает все генераторы. Func
	- set_throttle_individual -- устанавливает мощность генератора. Func. Аргументы: element (Number; index), throttle (Number; в процентах)
	- set_throttle -- устанавливает мощность всех генераторов. Func. Аргументы: throttle (Number; в процентах)

**FS** -- Fluid Storages. Table
- Название типа FS. Table
	- get_elements -- получает все proxy FS-s своего типа и записывает их в `_G.tags.[имя типа FS].elements`. Func
	- get_data_individual -- получает данные с FS и записывает их в `_G.tags.[имя типа FS].data[element]`. Func. Аргументы: element (Number; index)
	- get_data -- получает данные с FS-s и записывает их в `_G.tags.[имя типа FS].data`. Func
	
**ES** -- Enegry Storages. Table
- Название типа ES. Table
	- get_elements -- получает все proxy ES-s своего типа и записывает их в `_G.tags.[имя типа ES].elements`. Func
	- get_data_individual -- получает данные с ES и записывает их в `_G.tags.[имя типа ES].data[element]`. Func. Аргументы: element (Number; index)
	- get_data -- получает данные с ES-s и записывает их в `_G.tags.[имя типа ES].data`. Func
