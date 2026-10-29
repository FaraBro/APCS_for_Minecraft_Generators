_G.tags.gen.ntm_gas_turbine = {
	data = {},
	elements = {},
}
_G.drivers.gen.ntm_gas_turbine = {}

function _G.drivers.gen.ntm_gas_turbine.get_elements()
	if _G.config.auto_search_gens then
		index = 1
		for address in component.list("ntm_gas_turbine") do
			_G.tags.gen.ntm_gas_turbine.elements[index] = component.proxy(address)
			_G.tags.gen.ntm_gas_turbine.data[index] = {mode = _G.config.mode}
			index = index + 1
		end
	else
		for index, address, ext in ipairs(_G.config.manual_gens_address_table) do
			local ok, result = pcall(function(address)
				local element = component.proxy(address)
				assert(element.type == "ntm_gas_turbine", "Unvalid gen address")
				return element
			end, address)
			if ok then
				_G.tags.gen.ntm_gas_turbine.elements[index] = result
				if type(ext) == "table" then
					_G.tags.gen.ntm_gas_turbine.data[index] = ext
				else
					_G.tags.gen.ntm_gas_turbine.data[index] = {mode = _G.config.mode}
				end
			end
		end
	end
end

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
