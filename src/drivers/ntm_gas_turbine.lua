_G.tags.gen.ntm_gas_turbine = {
	data = {},
	elements = {},
}
_G.drivers.gen.ntm_gas_turbine = {}

function _G.drivers.gen.ntm_gas_turbine.get_elements()
	local defalut_ext = {
		mode = _G.config.mode,
	}
	if _G.config.auto_search_gens then
		index = 1
		for address in component.list("ntm_gas_turbine") do
			_G.tags.gen.ntm_gas_turbine.elements[index] = component.proxy(address)
			_G.tags.gen.ntm_gas_turbine.data[index] = defalut_ext
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
					_G.tags.gen.ntm_gas_turbine.data[index] = defalut_ext
				end
			end
		end
	end
end

function _G.drivers.gen.ntm_gas_turbine.get_data()
	for index, element in ipairs(_G.tags.gen.ntm_gas_turbine.elements) do
		_G.tags.gen.ntm_gas_turbine.data[index].fluid, _G.tags.gen.ntm_gas_turbine.data[index].max_fluid = element.getFluid()
		_G.tags.gen.ntm_gas_turbine.data[index] = {
			working = element.getState(),
			throttle = element.getThrottle(),
		}
	end
end

function _G.drivers.gen.ntm_gas_turbine.set_throttle(throttle)
	for element in pairs(_G.tags.gen.ntm_gas_turbine.elements) do
		_G.tags.gen.ntm_gas_turbine.elements[element].setThrottle(throttle)
	end
end

function _G.drivers.gen.ntm_gas_turbine.start()
	for index, element in ipairs(_G.tags.gen.ntm_gas_turbine.elements) do
		if _G.tags.gen.ntm_gas_turbine.data[index].working >= 0 then
			element.start()
		end
	end
end

function _G.drivers.gen.ntm_gas_turbine.stop()
	for element in pairs(_G.tags.gen.ntm_gas_turbine.elements) do
		element.stop()
	end
end
