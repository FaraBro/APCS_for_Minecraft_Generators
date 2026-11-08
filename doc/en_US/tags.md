**state** -- APCS State. String
- I -- Initialization
- O -- Operational
- M -- Manual
- E -- Emergency

**gen** -- Gens. Table. Is responsible for gen data, etc.
- Name of gens type. Table
	- data -- gens data. Table
		- Gen index. Table
			- ext -- ext from config. Anything. Unpack ext from config and all! Don't touch they. Mandatory [ext](#Gen-data-ext)
			- state -- Gen state. String. Don't touch they, main cycle all will do it for you.
				- "W" -- Working. Self Explanatory 
				- "S" -- Stopped. Self Explanatory
				- "M" -- Manual. Manual gen working, APCS don't redact gen, until state not will be reset
			- working -- Generator is working? Bool
			- fluid -- Fuel count in gen. Number
			- max_fluid -- Maximum fuel count in gen. Number
			- fluid_type -- type of fluid. String
			- throttle -- Gen power in proccentes. Number
	- elements -- Gens of this type (they component.proxy). Table

**FS** -- Fluid Storages. Table. Is responsible for FS data, etc.
- Name of FS type. Table
	- data -- FS data. Table
		- FS index. Table
			- fluid -- Fuel count in FS. Number. In mb
			- max_fluid -- Maximum fuel count in FS. Number. In mb
			- fluid_type -- fluid type. String
	- elements -- FS-s of this type (they component.proxy). Table

**ES** -- Energy Storages. Table. Is responsible for ES data, etc.
- Name of ES type. Table
	- data -- ES data. Table
		- ES index. Table
			- power -- Power count in ES. Number. In RF
			- max_power -- Maximum power count in ES. Number. In RF
	- elements -- ES-s of this type (they component.proxy). Table

**pid** -- PID-regulator. Table. Regulate gens power. It's separate module [pid.lua](/src/modules/pid.lua)
- k -- slope coefficient. Number
- b -- offset from 0 along the y-axis at x = 0. Number

**remote** -- remote module. Table. It's separate module [remote.lua](/src/modules/remote.lua) ([doc](/doc/en_US/remote.md))
- data_card -- proxy any data_card whose supported [AES enctypting](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard). Proxy-table

## Gen data ext

mode -- mode. Its mode
