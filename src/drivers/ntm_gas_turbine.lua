_G.tags.gen.ntm_gas_turbine = {
	data = {},
	elements = {},
}
_G.drivers.gen.ntm_gas_turbine = {}

function _G.drivers.gen.ntm_gas_turbine.get_data(element)
	_G.tags.gen.ntm_gas_turbine.data[element].fluid, _G.tags.gen.ntm_gas_turbine.data[element].max_fluid = _G.tags.gen.ntm_gas_turbine.elements[element].getFluid()
	_G.tags.gen.ntm_gas_turbine.data[element].fluid_type = _G.tags.gen.ntm_gas_turbine.elements[element].getType()
	_G.tags.gen.ntm_gas_turbine.data[element].working = _G.tags.gen.ntm_gas_turbine.elements[element].getState() ~= 0 or true and false
	_G.tags.gen.ntm_gas_turbine.data[element].throttle = _G.tags.gen.ntm_gas_turbine.elements[element].getThrottle()
end

function _G.drivers.gen.ntm_gas_turbine.set_throttle(element, throttle)
	_G.tags.gen.ntm_gas_turbine.elements[element].setThrottle(throttle)
end

function _G.drivers.gen.ntm_gas_turbine.start(element)
	_G.tags.gen.ntm_gas_turbine.elements[element].start()
end

function _G.drivers.gen.ntm_gas_turbine.stop(element)
	_G.tags.gen.ntm_gas_turbine.elements[element].stop()
end

function _G.drivers.gen.ntm_gas_turbine.init()
	_G.tags.gen.ntm_gas_turbine.elements, _G.tags.gen.ntm_gas_turbine.data = _G.drivers_tools.get_components("ntm_gas_turbine", "gen")
end
