_G.modules.pid = {
	control = {},
}
_G.tags.pid = {}

function _G.modules.pid.inspections()
	assert(_G.config.modes_config.gen_start ~= _G.config.modes_config.gen_stop, {"ERR E-101: gen_start = gen_stop", 101})
	assert(_G.config.modes_config.Y_max < 100 or _G.config.modes_config.Y_min < 100, {"ERR E-102: Y_max or Y_min > 100", 102})
	assert(_G.config.modes_config.Y_max > 0 or _G.config.modes_config.Y_min > 0, {"ERR E-103: Y_max or Y_min < 0", 103})
	assert(_G.config.modes_config.Y_max ~= _G.config.modes_config.Y_min, {"ERR E-104: Y_max = Y_min", 104})

	if _G.config.mode == 1 then
		assert(_G.config.modes_config.Y_max > _G.config.modes_config.Y_min, {"ERR E-105: Y_max < Y_min", 105})
		assert(_G.config.modes_config.gen_start > _G.config.modes_config.gen_stop, {"Err E-106: gen_start < gen_stop", 106})
	elseif _G.config.mode == 2 then
		assert(_G.config.modes_config.Y_max < _G.config.modes_config.Y_min, {"ERR E-107: Y_max > Y_min", 107})
		assert(_G.config.modes_config.gen_start < _G.config.modes_config.gen_stop, {"ERR E-108: gen_start > gen_stop", 108})
	else
		error({"ERR E-109: Unkown mode!", 109}, 0)
	end
end

function _G.modules.pid.init()
	_G.modules.pid.inspections()
	
	_G.tags.pid.k = 100 / (_G.config.modes_config.Y_max - _G.config.modes_config.Y_min)
	_G.tags.pid.b = _G.config.modes_config.Y_min * _G.tags.pid.k
end


local function one(gen_driver_name, gen_index, fluid, max_fluid)
	local fluid_prosent = fluid / max_fluid * 100
	if _G.tags.gen[gen_driver_name].data[gen_index].working then
		if fluid_prosent <= _G.config.modes_config.gen_stop then
			_G.drivers.gen[gen_driver_name].stop(gen_index)
			_G.tags.gen[gen_driver_name].data[gen_index].state = "S"
		elseif fluid_prosent <= _G.config.modes_config.Y_min then
			_G.drivers.gen[gen_driver_name].set_throttle(gen_index, 0)
		elseif fluid_prosent >= _G.config.modes_config.Y_max then
			_G.drivers.gen[gen_driver_name].set_throttle(gen_index, 100)
		else
			_G.drivers.gen[gen_driver_name].set_throttle(gen_index, _G.tags.pid.k * fluid_prosent - _G.tags.pid.b)
		end
	elseif fluid_prosent >= _G.config.modes_config.gen_start then
		_G.drivers.gen[gen_driver_name].start(gen_index)
		_G.tags.gen[gen_driver_name].data[gen_index].state = "W"
	end
end

_G.modules.pid.control[1] = one

local function two(gen_driver_name, gen_index, power, max_power)
	local power_prosent = power / max_power * 100
	if _G.tags.gen[gen_driver_name].data[gen_index].working then
		if power_prosent >= _G.config.modes_config.gen_stop then
			_G.drivers.gen[gen_driver_name].stop(gen_index)
			_G.tags.gen[gen_driver_name].data[gen_index].state = "S"
		elseif power_prosent >= _G.config.modes_config.Y_min then
			_G.drivers.gen[gen_driver_name].set_throttle(gen_index, 0)
		elseif power_prosent <= _G.config.modes_config.Y_max then
			_G.drivers.gen[gen_driver_name].set_throttle(gen_index, 100)
		else
			_G.drivers.gen[gen_driver_name].set_throttle(gen_index, _G.tags.pid.k * power_prosent - _G.tags.pid.b)
		end
	elseif power_prosent <= _G.config.modes_config.gen_start then
		_G.drivers.gen[gen_driver_name].start(gen_index)
		_G.tags.gen[gen_driver_name].data[1].state = "W"
	end
end

_G.modules.pid.control[2] = two
