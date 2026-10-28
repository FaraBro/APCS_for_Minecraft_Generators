**state** -- Стутус системы. String
- I -- Initialization
- O -- Operational

**gen** -- Генераторы. Table. Отвечает за данные с генераторов и т.п.
- Название типа генераторов. Table
	- data -- данные генераторов. Table
		- Индекс генератора. Table
			- ext -- ext из config. Anything. Распакуйте ext из конфига и всё! Не трогайте их.
			- working -- Работает ли генератор. Bool
			- fluid -- кол-во топлива в генераторе. Number
			- max_fluid -- максимальное кол-во топлива в генераторе. Number
			- fluid_type -- тип жидкости. String. Необязательно, но нужно для исправного счёта топлива в хранилищах. В случае если вы не знаете что за тип, то верните что-то уникальное, например название драйвера
			- throttle -- мощность генератора в процентах. Number
	- elements -- генераторы данного типа (их component.proxy). Table

**FS** -- Fluid Storages. Table. Отвечает за данные с FS и т.п.
- Название типа FS. Table
	- data -- данные FS-s. Table
		- Индекс FS-s. Table
			- fluid -- кол-во топлива в FS. Number. В mb
			- max_fluid -- максимальное кол-во жидкости в FS. Number. В mb
			- fluid_type -- тип жидкости. String
	- elements -- FS-s данного типа (их component.proxy). Table

**ES** -- Energy Storages. Table. Отвечает за данные с ES и т.п.
- Название типа ES. Table
	- data -- данные ES-s. Table
		- Индекс ES-s. Table
			- power -- кол-во заряда в ES. Number. В RF
			- max_power -- максимальное кол-во жидкости в ES. Number. В RF
	- elements -- ES-s данного типа (их component.proxy). Table

**pid** -- ПИД-регулятор. Table. Регулирует в принципе всё и вся. Является отдельным модулем [pid.lua](/src/modules/pid.lua)
- k -- угловой коэффициент
- b -- смещение от 0 по оси y при x = 0
