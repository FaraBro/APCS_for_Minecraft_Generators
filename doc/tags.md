**state** -- Стутус системы. String
- I -- Initialization
- O -- Operational

**gen** -- Генераторы. Table. Отвечает за данные с генераторов и т.п.
- Название типа генераторов. Table
	- data -- данные генераторов. Table
		- Индекс генератора. Table
			- working -- Работает ли генератор. Bool
			- fluid -- кол-во топлива в генераторе. Number
			- max_fluid -- максимальное кол-во топлива в генераторе. Number
			- throttle -- мощность генератора в процентах. Number
	- elements -- генераторы (их component.proxy). Table