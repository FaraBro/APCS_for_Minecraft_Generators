**gen** -- gens (driver_type). Table
- Gens name type (driver_name). Table
	- [init](#init)
	- get_data -- Get data from gen and write them to `_G.tags.gen[driver_name].data[element]`. Func. Arg: element (Number; index)
	- start -- Start gen. Func. Arg: element (Number; index)
	- stop -- Stop gen. Func. Arg: element (Number; index)
	- set_throttle -- Set gen power/throttle. Func. Arg: element (Number; index), throttle (Number; in percentage)

**FS** -- Fluid Storages (driver_type). Table
- FS name type (driver_name). Table
	- [init](#init)
	- get_data -- get data from FS and write them to `_G.tags.FS[driver_name].data[element]`. Func. Arg: element (Number; index)

**ES** -- Enegry Storages (driver_type). Table
- ES name type (driver_name). Table
	- [init](#init)
	- get_data -- get data from ES and write them to `_G.tags.ES[driver_name].data[element]`. Func. Arg: element (Number; index)

## drivers_tools
drivers_tools are standard driver utilities/tools  
We recommend using these within your drivers, as they help ensure compatibility when adding new extensions and also reduce the size of the driver file itself.  

## init
init -- optional element of any driver.  
Must be located in the driver root table (`_G.drivers[driver_type][driver_name].init` or `_G.drivers[driver_name].init`)  
We assume that in init you will assign [elements and them ext](/doc/en_US/tags.md), I’d like to remind you that you can use [drivers_tools](#drivers_tools)  
Any error in init is critical and will result in a BSoD (even if the settings are configured to "restart on error").  
