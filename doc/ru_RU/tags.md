**state** -- Стутус системы. String
- I -- Initialization
- O -- Operational
- M -- Manual
- E -- Emergency

**gen** -- Генераторы. Table. Отвечает за данные с генераторов и т.п.
- Название типа генераторов. Table
	- data -- данные генераторов. Table
		- Индекс генератора. Table
			- ext -- ext из config. Anything. Распакуйте ext из конфига и всё! Не трогайте их. Обязательные [ext](#Gen-data-ext)
			- state -- Статус генератора. String. Его вообще не трогайте main cycle всё сделает за вас.
				- "W" -- Working. Работает, как раз таки и должен работать
				- "S" -- Stopped. Остановлен, должен быть остановлен
				- "M" -- Manual. Ручной режим работы, APCS не вмешивается в работу gen, пока статус не сбросят
			- working -- Работает ли генератор. Bool
			- fluid -- кол-во топлива в генераторе. Number
			- max_fluid -- максимальное кол-во топлива в генераторе. Number
			- fluid_type -- тип жидкости. String
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
			- max_power -- максимальное кол-во заряда в ES. Number. В RF
	- elements -- ES-s данного типа (их component.proxy). Table

**pid** -- ПИД-регулятор. Table. Регулирует в принципе всё и вся. Является отдельным модулем [pid.lua](/src/modules/pid.lua)
- k -- угловой коэффициент. Number
- b -- смещение от 0 по оси y при x = 0. Number

**remote** -- remote модуль. Table. Является отдельным модулем [remote.lua](/src/modules/remote.lua) ([документация](/doc/ru_RU/remote.md))
- data_card -- proxy любого data_card, который поддерживает [AES шифрование](https://ru.wikipedia.org/wiki/AES_(%D1%81%D1%82%D0%B0%D0%BD%D0%B4%D0%B0%D1%80%D1%82_%D1%88%D0%B8%D1%84%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D1%8F). Proxy-table

## Gen data ext

mode -- mode. Его значение по умолчанию находится в [config](/src/core/config.lua) ([документация](/doc/ru_RU/config.md))
